defmodule KralukKurkierewiczWeb.PageControllerTest do
  use KralukKurkierewiczWeb.ConnCase

  alias KralukKurkierewicz.Blog

  defp json_ld_graph(html) do
    [_, json] = Regex.run(~r{<script type="application/ld\+json">\s*(.*?)\s*</script>}s, html)
    json |> Jason.decode!() |> Map.fetch!("@graph")
  end

  defp types(graph), do: Enum.map(graph, & &1["@type"])

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    response = html_response(conn, 200)
    assert response =~ "Kraluk Kurkierewicz"
    assert response =~ "Pomoc prawna"
  end

  test "home page H1 names the firm and city", %{conn: conn} do
    html = conn |> get(~p"/") |> html_response(200)

    assert [h1] = Regex.scan(~r{<h1[^>]*>(.*?)</h1>}s, html, capture: :all_but_first)

    assert h1 |> hd() |> String.replace(~r/<[^>]+>|\s+/, " ") =~
             "Kancelaria adwokacka Gdańsk – Kraluk Kurkierewicz"
  end

  test "home page JSON-LD has firm, both partners and an FAQPage matching the visible FAQ",
       %{conn: conn} do
    html = conn |> get(~p"/") |> html_response(200)
    graph = json_ld_graph(html)

    assert ["LegalService", "Person", "Person", "WebSite", "FAQPage"] = types(graph)

    firm = Enum.find(graph, &(&1["@type"] == "LegalService"))
    assert firm["telephone"] == "+48698359581"
    assert firm["address"]["streetAddress"] == "ul. Strzelecka 7B"
    assert [%{"opens" => "09:00", "closes" => "17:00"}] = firm["openingHoursSpecification"]

    faq = Enum.find(graph, &(&1["@type"] == "FAQPage"))
    assert length(faq["mainEntity"]) == length(KralukKurkierewiczWeb.StructuredData.faq())

    for %{"name" => question} <- faq["mainEntity"] do
      assert html =~ Phoenix.HTML.html_escape(question) |> Phoenix.HTML.safe_to_string()
    end
  end

  test "blog post JSON-LD has Article and BreadcrumbList", %{conn: conn} do
    post = hd(Blog.list_posts())
    graph = conn |> get(~p"/blog/#{post.slug}") |> html_response(200) |> json_ld_graph()

    article = Enum.find(graph, &(&1["@type"] == "Article"))
    assert article["headline"] == post.title

    crumbs = Enum.find(graph, &(&1["@type"] == "BreadcrumbList"))
    assert ["Strona główna", "Blog", title] = Enum.map(crumbs["itemListElement"], & &1["name"])
    assert title == post.title
  end

  test "blog index has a BreadcrumbList", %{conn: conn} do
    graph = conn |> get(~p"/blog") |> html_response(200) |> json_ld_graph()
    assert "BreadcrumbList" in types(graph)
  end

  test "GET /llms.txt returns a plain-text summary with blog links", %{conn: conn} do
    conn = conn |> put_req_header("accept", "text/plain") |> get("/llms.txt")
    body = response(conn, 200)

    assert [content_type] = get_resp_header(conn, "content-type")
    assert content_type =~ "text/plain"
    assert body =~ "# Kraluk Kurkierewicz Adwokacka Spółka Partnerska"
    assert body =~ "698 359 581"
    assert body =~ "793 102 489"

    for post <- Blog.list_posts(), do: assert(body =~ "/blog/#{post.slug}")
  end
end
