defmodule KralukKurkierewiczWeb.PageController do
  use KralukKurkierewiczWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end

  def privacy(conn, _params) do
    render(conn, :privacy)
  end

  # Dynamic XML sitemap so the host is always correct across environments.
  def sitemap(conn, _params) do
    lastmod = Date.to_iso8601(Date.utc_today())
    base = KralukKurkierewiczWeb.Endpoint.url()
    urls = [{~p"/", "1.0"}, {~p"/polityka-prywatnosci", "0.5"}]

    entries =
      Enum.map_join(urls, "\n", fn {path, priority} ->
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
