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

  describe "blog post authorship and links" do
    test "shows author byline, bio, update date and Person author in JSON-LD", %{conn: conn} do
      post = Blog.get_post("upadlosc-konsumencka")
      html = conn |> get(~p"/blog/#{post.slug}") |> html_response(200)

      assert html =~ ~s(id="post-byline")
      assert html =~ "adw. Michał Kurkierewicz"
      assert html =~ ~s(id="autor")
      assert html =~ "Zaktualizowano:"
      assert html =~ "22 listopada 2026"
      assert html =~ "isap.sejm.gov.pl/isap.nsf/DocDetails.xsp?id=WDU20030600535"
      assert html =~ ~s(href="/uslugi/upadlosc-konsumencka")

      article = html |> json_ld_graph() |> Enum.find(&(&1["@type"] == "Article"))
      assert article["author"]["@id"] =~ "#michal-kurkierewicz"
      assert article["dateModified"] == "2026-11-22"
      assert article["datePublished"] == Date.to_iso8601(post.date)
    end

    test "every post has a known author, an existing service page and ISAP links", %{conn: conn} do
      for post <- Blog.list_posts() do
        assert KralukKurkierewicz.Team.get!(post.author)
        assert KralukKurkierewicz.Services.get(post.service)
        html = conn |> get(~p"/blog/#{post.slug}") |> html_response(200)
        assert html =~ "isap.sejm.gov.pl"
        assert html =~ ~s(href="/uslugi/#{post.service}")
      end
    end
  end

  describe "service pages" do
    test "each service page renders with Service + BreadcrumbList JSON-LD and ISAP links",
         %{conn: conn} do
      for service <- KralukKurkierewicz.Services.list() do
        html = conn |> get(~p"/uslugi/#{service.slug}") |> html_response(200)
        assert html =~ "Podstawa prawna"
        assert html =~ ~r{isap\.sejm\.gov\.pl|eur-lex\.europa\.eu}

        graph = json_ld_graph(html)
        assert "Service" in types(graph)
        assert "BreadcrumbList" in types(graph)
      end
    end

    test "service page lists its related blog posts", %{conn: conn} do
      html = conn |> get(~p"/uslugi/sprawy-rodzinne") |> html_response(200)
      assert html =~ ~s(href="/blog/wysokosc-alimentow-na-dziecko")
    end

    test "unknown service is a 404", %{conn: conn} do
      assert conn |> get("/uslugi/nie-ma") |> response(404)
    end

    test "home links to service pages and sitemap lists them", %{conn: conn} do
      html = conn |> get(~p"/") |> html_response(200)
      sitemap = conn |> get(~p"/sitemap.xml") |> response(200)

      for service <- KralukKurkierewicz.Services.list() do
        assert html =~ ~s(href="/uslugi/#{service.slug}")
        assert sitemap =~ "/uslugi/#{service.slug}</loc>"
      end
    end
  end

  describe "local SEO signals" do
    test "LegalService has city-level areaServed and geo coordinates", %{conn: conn} do
      graph = conn |> get(~p"/") |> html_response(200) |> json_ld_graph()
      firm = Enum.find(graph, &(&1["@type"] == "LegalService"))

      names = Enum.map(firm["areaServed"], & &1["name"])

      for city <- ["Gdańsk", "Gdynia", "Sopot", "Pruszcz Gdański", "Starogard Gdański"] do
        assert city in names
      end

      assert "województwo pomorskie" in names

      milena = Enum.find(graph, &(&1["@id"] =~ "#milena-kraluk"))
      assert milena["sameAs"] == ["https://rejestradwokatow.pl/adwokat/kraluk-milena-83554"]

      michal = Enum.find(graph, &(&1["@id"] =~ "#michal-kurkierewicz"))
      assert michal["sameAs"] == ["https://rejestradwokatow.pl/adwokat/kurkierewicz-micha-81186"]
      assert %{"@type" => "GeoCoordinates", "latitude" => _, "longitude" => _} = firm["geo"]
    end

    test "service-area sentence appears in the FAQ and in llms.txt", %{conn: conn} do
      sentence = KralukKurkierewiczWeb.StructuredData.area_sentence()
      html = conn |> get(~p"/") |> html_response(200)
      llms = conn |> get("/llms.txt") |> response(200)

      assert html =~ sentence
      assert llms =~ sentence
    end

    test "blog posts use og:type article with article meta, other pages website", %{conn: conn} do
      post = hd(Blog.list_posts())
      post_html = conn |> get(~p"/blog/#{post.slug}") |> html_response(200)
      home_html = conn |> get(~p"/") |> html_response(200)

      assert post_html =~ ~s(<meta property="og:type" content="article">)

      assert post_html =~
               ~s(<meta property="article:published_time" content="#{Date.to_iso8601(post.date)}">)

      assert home_html =~ ~s(<meta property="og:type" content="website">)
    end
  end

  describe "team pages, pricing, service FAQ and related posts" do
    test "partner page renders ProfilePage and Person.url points to it", %{conn: conn} do
      html = conn |> get(~p"/zespol/milena-kraluk") |> html_response(200)
      assert html =~ "rejestradwokatow.pl/adwokat/kraluk-milena-83554"
      assert html =~ ~s(href="/blog/kredyt-po-rozwodzie")

      graph = json_ld_graph(html)
      assert "ProfilePage" in types(graph)
      person = Enum.find(graph, &(&1["@id"] =~ "#milena-kraluk"))
      assert person["url"] =~ "/zespol/milena-kraluk"
    end

    test "unknown partner is a 404", %{conn: conn} do
      assert conn |> get("/zespol/nikt") |> response(404)
    end

    test "pricing page lists ranges and emits an OfferCatalog", %{conn: conn} do
      html = conn |> get(~p"/cennik") |> html_response(200)
      assert html =~ "Konsultacja prawna"
      assert html =~ "250–450 zł"
      assert "OfferCatalog" in types(json_ld_graph(html))
    end

    test "LegalService priceRange comes from the price list", %{conn: conn} do
      firm =
        conn
        |> get(~p"/")
        |> html_response(200)
        |> json_ld_graph()
        |> Enum.find(&(&1["@type"] == "LegalService"))

      {min, max} = KralukKurkierewicz.Pricing.bounds()
      assert firm["priceRange"] == KralukKurkierewicz.Pricing.format_range(min, max)
    end

    test "every service page has a visible FAQ matching its FAQPage", %{conn: conn} do
      for service <- KralukKurkierewicz.Services.list() do
        html = conn |> get(~p"/uslugi/#{service.slug}") |> html_response(200)
        faq = html |> json_ld_graph() |> Enum.find(&(&1["@type"] == "FAQPage"))
        assert length(faq["mainEntity"]) == 2, service.slug

        for %{"name" => q} <- faq["mainEntity"] do
          assert html =~ q |> Phoenix.HTML.html_escape() |> Phoenix.HTML.safe_to_string()
        end
      end
    end

    test "blog post shows related posts and links byline to the author page", %{conn: conn} do
      html = conn |> get(~p"/blog/wysokosc-alimentow-na-dziecko") |> html_response(200)
      assert html =~ ~s(id="related")
      assert html =~ ~s(href="/blog/kredyt-po-rozwodzie")
      assert html =~ ~s(href="/zespol/milena-kraluk")
    end

    test "footer and llms.txt link every service, partner page and the price list", %{conn: conn} do
      html = conn |> get(~p"/blog") |> html_response(200)
      llms = conn |> get("/llms.txt") |> response(200)
      sitemap = conn |> get(~p"/sitemap.xml") |> response(200)

      paths =
        Enum.map(KralukKurkierewicz.Services.list(), &"/uslugi/#{&1.slug}") ++
          ["/zespol/milena-kraluk", "/zespol/michal-kurkierewicz", "/cennik"]

      for path <- paths do
        assert html =~ ~s(href="#{path}")
        assert llms =~ path
        assert sitemap =~ path <> "</loc>"
      end
    end
  end
end
