defmodule KralukKurkierewiczWeb.PageController do
  use KralukKurkierewiczWeb, :controller

  alias KralukKurkierewicz.Blog
  alias KralukKurkierewicz.Services
  alias KralukKurkierewicz.Team
  alias KralukKurkierewiczWeb.StructuredData

  def home(conn, _params) do
    # The hero headline is set in Cormorant italic; preload it so it isn't discovered only after app.css
    conn
    |> assign(
      :preload_fonts,
      ~w(cormorant-garamond-italic-latin.woff2 cormorant-garamond-italic-latin-ext.woff2)
    )
    |> assign(:json_ld, [StructuredData.faq_page()])
    |> render(:home, faq: StructuredData.faq())
  end

  def blog(conn, _params) do
    conn
    |> assign(:active_nav, "blog")
    |> assign(:page_title, "Blog — Kraluk Kurkierewicz")
    |> assign(
      :meta_description,
      "Blog kancelarii Kraluk Kurkierewicz — omawiamy orzecznictwo i zmiany w przepisach istotne dla naszych Klientów: spory z deweloperami, prawo cywilne, rodzinne i gospodarcze."
    )
    |> assign(:json_ld, [StructuredData.breadcrumbs([{"Blog", "/blog"}])])
    |> render(:blog, posts: Blog.list_posts())
  end

  def blog_post(conn, %{"slug" => slug}) do
    case Blog.get_post(slug) do
      nil ->
        raise Phoenix.Router.NoRouteError, conn: conn, router: KralukKurkierewiczWeb.Router

      post ->
        conn
        |> assign(:active_nav, "blog")
        |> assign(:page_title, post.meta_title || branded_title(post.title))
        |> assign(:meta_description, post.description)
        |> assign(:canonical_path, "/blog/#{post.slug}")
        |> assign(:og_type, "article")
        |> assign(:og_article, %{
          published: Date.to_iso8601(post.date),
          modified: Date.to_iso8601(Blog.last_modified(post)),
          author: Team.get!(post.author).name,
          section: post.category
        })
        |> assign(:json_ld, [
          StructuredData.article(post),
          StructuredData.breadcrumbs([{"Blog", "/blog"}, {post.title, "/blog/#{post.slug}"}])
        ])
        |> render(:blog_post,
          post: post,
          author: Team.get!(post.author),
          service: post.service && Services.get(post.service),
          related: Blog.related(post)
        )
    end
  end

  def service(conn, %{"slug" => slug}) do
    case Services.get(slug) do
      nil ->
        raise Phoenix.Router.NoRouteError, conn: conn, router: KralukKurkierewiczWeb.Router

      service ->
        details = KralukKurkierewicz.ServiceDetails.get(service.slug)
        leads = Enum.map(KralukKurkierewicz.ServiceDetails.leads(service.slug), &Team.get!/1)
        updated = Services.updated(service)

        conn
        |> assign(:active_nav, "specjalizacje")
        |> assign(:page_title, branded_title(service.meta_title))
        |> assign(:meta_description, service.description)
        |> assign(:canonical_path, "/uslugi/#{service.slug}")
        |> assign(:json_ld, [
          StructuredData.service(service),
          StructuredData.service_page(service, updated, leads),
          StructuredData.faq_page(Services.faq(service), "/uslugi/#{service.slug}"),
          StructuredData.breadcrumbs([{service.name, "/uslugi/#{service.slug}"}])
        ])
        |> render(:service,
          service: service,
          faq: Services.faq(service),
          details: details,
          leads: leads,
          updated: updated,
          summary: Services.summary(service),
          related: Services.related(service),
          posts: Blog.posts_for_service(service.slug)
        )
    end
  end

  def team_member(conn, %{"slug" => slug}) do
    case Enum.find(Team.list(), &(&1.slug == slug)) do
      nil ->
        raise Phoenix.Router.NoRouteError, conn: conn, router: KralukKurkierewiczWeb.Router

      member ->
        conn
        |> assign(:active_nav, "zespol")
        |> assign(:page_title, "#{member.display_name} — adwokat Gdańsk | Kraluk Kurkierewicz")
        |> assign(
          :meta_description,
          "#{member.display_name} — adwokat i partner w Kancelarii Kraluk Kurkierewicz w Gdańsku. Członek Pomorskiej Izby Adwokackiej, ponad 10 lat doświadczenia. Artykuły i kontakt."
        )
        |> assign(:canonical_path, "/zespol/#{member.slug}")
        |> assign(:json_ld, [
          StructuredData.profile_page(member),
          StructuredData.breadcrumbs([
            {"Zespół", "/#zespol"},
            {member.display_name, "/zespol/#{member.slug}"}
          ])
        ])
        |> render(:team_member,
          member: member,
          posts: Blog.posts_by_author(member.slug),
          services: Enum.map(member.services, &Services.get/1)
        )
    end
  end

  # The price list was removed; its old address keeps working for existing links.
  def pricing(conn, _params) do
    conn |> put_status(:moved_permanently) |> redirect(to: ~p"/")
  end

  # Google cuts titles at roughly 60 characters (and Bing flags those over 70), so the
  # brand suffix is dropped when it would not fit.
  defp branded_title(title) do
    branded = title <> " — Kraluk Kurkierewicz"
    if String.length(branded) <= 60, do: branded, else: title
  end

  def privacy(conn, _params) do
    conn
    |> assign(:page_title, "Polityka prywatności — Kraluk Kurkierewicz")
    |> assign(
      :meta_description,
      "Polityka prywatności oraz informacje o przetwarzaniu danych osobowych w kancelarii Kraluk Kurkierewicz Adwokacka Spółka Partnerska w Gdańsku."
    )
    |> assign(:json_ld, [
      StructuredData.breadcrumbs([{"Polityka prywatności", "/polityka-prywatnosci"}])
    ])
    |> render(:privacy)
  end

  # Dynamic XML sitemap so the host is always correct across environments.
  # Pages and their `lastmod` dates come from `KralukKurkierewicz.Sitemap`.
  def sitemap(conn, _params) do
    base = KralukKurkierewiczWeb.Endpoint.url()

    entries =
      Enum.map_join(KralukKurkierewicz.Sitemap.entries(), "\n", fn {path, priority, lastmod} ->
        loc = base <> String.trim_trailing(path, "/")

        """
          <url>
            <loc>#{loc}</loc>
            <lastmod>#{Date.to_iso8601(lastmod)}</lastmod>
            <priority>#{priority}</priority>
          </url>\
        """
      end)

    xml = """
    <?xml version="1.0" encoding="UTF-8"?>
    <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
    #{entries}
    </urlset>
    """

    conn
    |> put_resp_content_type("application/xml")
    |> send_resp(200, xml)
  end

  # https://llmstxt.org — Markdown summary of the firm for LLM-based search/assistants.
  # Firm facts mirror the home page and StructuredData; blog links come from Blog.
  def llms_txt(conn, _params) do
    base = KralukKurkierewiczWeb.Endpoint.url()

    posts =
      Enum.map_join(Blog.list_posts(), "\n", fn post ->
        "- [#{post.title}](#{base}/blog/#{post.slug}): #{post.description}"
      end)

    services =
      Enum.map_join(Services.list(), "\n", fn service ->
        "- [#{service.name}](#{base}/uslugi/#{service.slug}): #{service.description}"
      end)

    team_pages =
      Enum.map_join(Team.list(), "\n", fn member ->
        "- [#{member.display_name}](#{base}/zespol/#{member.slug}): #{member.role}"
      end)

    service_pages =
      Enum.map_join(Services.list(), "\n", fn service ->
        "- [#{service.name}](#{base}/uslugi/#{service.slug})"
      end)

    faq =
      Enum.map_join(StructuredData.faq(), "\n\n", fn {question, answer} ->
        "### #{question}\n\n#{answer}"
      end)

    body = """
    # Kraluk Kurkierewicz Adwokacka Spółka Partnerska

    > Kancelaria adwokacka w Gdańsku (ul. Strzelecka 7B, 80-803 Gdańsk). Adwokaci Milena Kraluk i Michał Kurkierewicz prowadzą sprawy cywilne, rodzinne, spadkowe, odszkodowawcze, spory z deweloperami i upadłość konsumencką oraz zapewniają obsługę prawną przedsiębiorców. Pomoc prawna także w formie e-porady (telefon lub wideo).

    #{StructuredData.area_sentence()}

    ## Kontakt

    - Telefon: 698 359 581, 793 102 489
    - E-mail: kontakt@kkadwokat.pl
    - Adres: ul. Strzelecka 7B, 80-803 Gdańsk
    - Godziny pracy: poniedziałek–piątek, 9:00–17:00
    - KRS: 0001151792
    - Strona: #{base}/

    ## Zespół

    - adw. Milena Kraluk — Partner, adwokat
    - adw. Michał Kurkierewicz — Partner, adwokat

    Absolwenci Wydziału Prawa i Administracji Uniwersytetu Gdańskiego, członkowie Pomorskiej Izby Adwokackiej w Gdańsku, z ponad 10-letnim doświadczeniem zawodowym.

    ## Specjalizacje

    - Dla osób prywatnych: sprawy o zapłatę, odszkodowania i zadośćuczynienia, zawyżony metraż mieszkań, nieruchomości, rozwody, alimenty, sprawy rodzinne (kontakty z dzieckiem, władza rodzicielska), podział majątku małżonków, prawa konsumentów, upadłość konsumencka, sprawy spadkowe, zachowek, prawo karne (reprezentacja pokrzywdzonych).
    - Dla przedsiębiorców: bieżąca obsługa prawna, zakładanie spółek, umowy, egzekucja wierzytelności, restrukturyzacja, obsługa korporacyjna i spory masowe, AI i nowe technologie, sukcesja firm rodzinnych, prawo medyczne, spory gospodarcze, RODO.

    ## Usługi

    #{services}

    ## Najczęstsze pytania

    #{faq}

    ## Blog

    #{posts}

    ## Strony

    - [Strona główna](#{base}/): specjalizacje, sposób pracy, zespół, kontakt
    - [Blog](#{base}/blog): artykuły o orzecznictwie i zmianach w przepisach
    #{team_pages}
    #{service_pages}
    - [Polityka prywatności](#{base}/polityka-prywatnosci)
    """

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, body)
  end

  def contact(conn, params) do
    with {:ok, fields} <- validate(params),
         {:ok, _email} <- KralukKurkierewicz.ContactEmail.deliver(fields) do
      json(conn, %{status: "ok", message: "Wiadomość wysłana. Dziękujemy!"})
    else
      {:error, :invalid} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{status: "error", message: "Uzupełnij wszystkie pola formularza."})

      {:error, _reason} ->
        conn
        |> put_status(:bad_gateway)
        |> json(%{status: "error", message: "Nie udało się wysłać wiadomości. Spróbuj ponownie."})
    end
  end

  defp validate(params) do
    fields =
      Map.new(~w(name contact message), fn key ->
        {key, params |> Map.get(key, "") |> to_string() |> String.trim()}
      end)

    if Enum.any?(fields, fn {_key, value} -> value == "" end) do
      {:error, :invalid}
    else
      {:ok, fields}
    end
  end
end
