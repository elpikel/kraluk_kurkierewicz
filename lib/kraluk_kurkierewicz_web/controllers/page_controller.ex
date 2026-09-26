defmodule KralukKurkierewiczWeb.PageController do
  use KralukKurkierewiczWeb, :controller

  alias KralukKurkierewicz.Blog

  def home(conn, _params) do
    render(conn, :home)
  end

  def blog(conn, _params) do
    conn
    |> assign(:active_nav, "blog")
    |> assign(:page_title, "Blog — Kraluk Kurkierewicz")
    |> assign(
      :meta_description,
      "Blog kancelarii Kraluk Kurkierewicz — omawiamy orzecznictwo i zmiany w przepisach istotne dla naszych Klientów: spory z deweloperami, prawo cywilne, rodzinne i gospodarcze."
    )
    |> render(:blog, posts: Blog.list_posts())
  end

  def blog_post(conn, %{"slug" => slug}) do
    case Blog.get_post(slug) do
      nil ->
        raise Phoenix.Router.NoRouteError, conn: conn, router: KralukKurkierewiczWeb.Router

      post ->
        conn
        |> assign(:active_nav, "blog")
        |> assign(:page_title, post.title <> " — Kraluk Kurkierewicz")
        |> assign(:meta_description, post.description)
        |> assign(:canonical_path, "/blog/#{post.slug}")
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
