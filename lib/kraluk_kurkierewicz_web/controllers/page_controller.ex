defmodule KralukKurkierewiczWeb.PageController do
  use KralukKurkierewiczWeb, :controller

  alias KralukKurkierewicz.Blog
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
        |> assign(:page_title, post.meta_title || post.title <> " — Kraluk Kurkierewicz")
        |> assign(:meta_description, post.description)
        |> assign(:canonical_path, "/blog/#{post.slug}")
        |> assign(:json_ld, [
          StructuredData.article(post),
          StructuredData.breadcrumbs([{"Blog", "/blog"}, {post.title, "/blog/#{post.slug}"}])
        ])
        |> render(:blog_post, post: post)
    end
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
  # `lastmod` reflects the real last content update per page — bump it when the
  # page copy changes so the signal stays trustworthy to crawlers.
  def sitemap(conn, _params) do
    base = KralukKurkierewiczWeb.Endpoint.url()

    post_urls =
      Enum.map(Blog.list_posts(), fn post ->
        {"/blog/#{post.slug}", "0.6", Date.to_iso8601(post.date)}
      end)

    urls =
      [
        {~p"/", "1.0", "2026-09-23"},
        {~p"/blog", "0.7", "2026-09-23"}
      ] ++ post_urls ++ [{~p"/polityka-prywatnosci", "0.5", "2026-09-23"}]

    entries =
      Enum.map_join(urls, "\n", fn {path, priority, lastmod} ->
        loc = base <> String.trim_trailing(path, "/")

        """
          <url>
            <loc>#{loc}</loc>
            <lastmod>#{lastmod}</lastmod>
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

    faq =
      Enum.map_join(StructuredData.faq(), "\n\n", fn {question, answer} ->
        "### #{question}\n\n#{answer}"
      end)

    body = """
    # Kraluk Kurkierewicz Adwokacka Spółka Partnerska

    > Kancelaria adwokacka w Gdańsku (ul. Strzelecka 7B, 80-803 Gdańsk). Adwokaci Milena Kraluk i Michał Kurkierewicz prowadzą sprawy cywilne, rodzinne, spadkowe, odszkodowawcze, spory z deweloperami i upadłość konsumencką oraz zapewniają obsługę prawną przedsiębiorców. Pomoc prawna na terenie całej Polski, także w formie e-porady (telefon lub wideo).

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

    - Dla osób prywatnych: sprawy o zapłatę, odszkodowania i zadośćuczynienia, zawyżony metraż mieszkań, nieruchomości, sprawy rodzinne (rozwody, alimenty, władza rodzicielska), podział majątku małżonków, prawa konsumentów, upadłość konsumencka, sprawy spadkowe, prawo karne (reprezentacja pokrzywdzonych).
    - Dla przedsiębiorców: bieżąca obsługa prawna, zakładanie spółek, umowy, egzekucja wierzytelności, restrukturyzacja, obsługa korporacyjna i spory masowe, AI i nowe technologie, sukcesja firm rodzinnych, prawo medyczne, spory gospodarcze, RODO.

    ## Najczęstsze pytania

    #{faq}

    ## Blog

    #{posts}

    ## Strony

    - [Strona główna](#{base}/): specjalizacje, sposób pracy, zespół, kontakt
    - [Blog](#{base}/blog): artykuły o orzecznictwie i zmianach w przepisach
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
