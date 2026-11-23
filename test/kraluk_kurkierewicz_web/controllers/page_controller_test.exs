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
      html = conn |> get(~p"/uslugi/alimenty") |> html_response(200)
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

    test "partner page main content shows only that partner's phone", %{conn: conn} do
      for {slug, own, other} <- [
            {"milena-kraluk", "698359581", "793102489"},
            {"michal-kurkierewicz", "793102489", "698359581"}
          ] do
        html = conn |> get(~p"/zespol/#{slug}") |> html_response(200)
        [_, main] = Regex.run(~r{</header>(.*)<footer}s, html)
        assert main =~ "tel:+48#{own}"
        refute main =~ "tel:+48#{other}"
      end
    end

    test "unknown partner is a 404", %{conn: conn} do
      assert conn |> get("/zespol/nikt") |> response(404)
    end

    test "the removed price list redirects home and no page shows lawyer fees", %{conn: conn} do
      assert conn |> get("/cennik") |> redirected_to(301) == "/"

      for {path, _priority, _date} <- KralukKurkierewicz.Sitemap.entries() do
        html = conn |> get(path) |> html_response(200)
        refute html =~ "/cennik"
        refute html =~ "Orientacyjne ceny"
        refute html =~ "Wynagrodzenie adwokata"
        refute html =~ "priceRange"
      end

      refute conn |> get("/llms.txt") |> response(200) =~ "ennik"
    end

    test "every service page has a visible FAQ matching its FAQPage", %{conn: conn} do
      for service <- KralukKurkierewicz.Services.list() do
        html = conn |> get(~p"/uslugi/#{service.slug}") |> html_response(200)
        faq = html |> json_ld_graph() |> Enum.find(&(&1["@type"] == "FAQPage"))
        assert length(faq["mainEntity"]) == length(KralukKurkierewicz.Services.faq(service))

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

    test "footer and llms.txt link every service, and partner page", %{conn: conn} do
      html = conn |> get(~p"/blog") |> html_response(200)
      llms = conn |> get("/llms.txt") |> response(200)
      sitemap = conn |> get(~p"/sitemap.xml") |> response(200)

      paths =
        Enum.map(KralukKurkierewicz.Services.list(), &"/uslugi/#{&1.slug}") ++
          ["/zespol/milena-kraluk", "/zespol/michal-kurkierewicz"]

      for path <- paths do
        assert html =~ ~s(href="#{path}")
        assert llms =~ path
        assert sitemap =~ path <> "</loc>"
      end
    end
  end

  describe "extended service pages" do
    test "the key pages have 1000+ words, 6+ FAQ entries, documents and a lead lawyer",
         %{conn: conn} do
      for slug <- KralukKurkierewicz.ServiceDetails.slugs() do
        html = conn |> get(~p"/uslugi/#{slug}") |> html_response(200)
        [_, main] = Regex.run(~r{</header>(.*)<footer}s, html)

        words =
          main
          |> String.replace(~r{<script.*?</script>}s, " ")
          |> String.replace(~r{<[^>]+>}, " ")
          |> String.split(~r/\s+/, trim: true)
          |> length()

        assert words >= 1000, "#{slug}: #{words} words"

        faq = html |> json_ld_graph() |> Enum.find(&(&1["@type"] == "FAQPage"))
        assert length(faq["mainEntity"]) >= 10, slug
        assert html =~ ~s(id="dokumenty")
        assert html =~ ~s(id="service-lead-)
      end
    end

    test "zawyżony metraż has the overpayment calculator and published rulings", %{conn: conn} do
      html = conn |> get(~p"/uslugi/zawyzony-metraz") |> html_response(200)
      assert html =~ ~s(id="metraz-calc")
      assert html =~ "IV Ca 1735/23"
      assert html =~ "orzeczenia.ms.gov.pl"
      assert html =~ "sześcioletnim terminie"
    end

    test "every service page has a local section, question FAQ and working inline links",
         %{conn: conn} do
      slugs = Enum.map(KralukKurkierewicz.Services.list(), & &1.slug)

      for service <- KralukKurkierewicz.Services.list() do
        html = conn |> get(~p"/uslugi/#{service.slug}") |> html_response(200)
        [_, local] = Regex.run(~r{id="w-gdansku">(.*?)</div>}s, html)
        assert local =~ ~r/Gdańsk/, service.slug

        faq = KralukKurkierewicz.Services.faq(service)
        assert length(faq) >= 10, service.slug
        for {question, _answer} <- faq, do: assert(String.ends_with?(question, "?"), question)

        # `[label](/path)` markup is always rendered, never shown raw
        refute html =~ "](/", service.slug
        for [_, slug] <- Regex.scan(~r{href="/uslugi/([^"#]+)"}, html), do: assert(slug in slugs)
        assert String.length(service.description) <= 160, service.slug
      end
    end

    test "inline links are rendered as anchors and other text is escaped" do
      html =
        "A <b> [strona](/uslugi/rozwod) [zewn](https://example.com)"
        |> KralukKurkierewiczWeb.PageHTML.linked()
        |> Phoenix.HTML.safe_to_string()

      assert html =~ ~s(href="/uslugi/rozwod")
      assert html =~ "&lt;b&gt;"
      refute html =~ ~s(href="https://example.com")
    end

    test "every service page is a full page with question headings and a lead lawyer",
         %{conn: conn} do
      assert Enum.sort(KralukKurkierewicz.ServiceDetails.slugs()) ==
               Enum.sort(Enum.map(KralukKurkierewicz.Services.list(), & &1.slug))

      for service <- KralukKurkierewicz.Services.list() do
        html = conn |> get(~p"/uslugi/#{service.slug}") |> html_response(200)
        questions = Regex.scan(~r{<h2[^>]*>[^<]*\?\s*</h2>}, html)
        assert length(questions) >= 4, service.slug
      end
    end

    test "every service H1 names the city", %{conn: conn} do
      for service <- KralukKurkierewicz.Services.list() do
        html = conn |> get(~p"/uslugi/#{service.slug}") |> html_response(200)
        [_, h1] = Regex.run(~r{<h1[^>]*>(.*?)</h1>}s, html)
        assert h1 =~ "Gdańsk", service.slug
      end
    end

    test "sitemap lastmod comes from each page's own content date", %{conn: conn} do
      sitemap = conn |> get(~p"/sitemap.xml") |> response(200)

      for service <- KralukKurkierewicz.Services.list() do
        date = Date.to_iso8601(KralukKurkierewicz.Services.updated(service))
        assert sitemap =~ ~r{/uslugi/#{service.slug}</loc>\s*<lastmod>#{date}</lastmod>}
      end
    end
  end

  describe "audit follow-ups: divorce page, summaries, related services, profiles" do
    test "no page title exceeds 70 characters", %{conn: conn} do
      for {path, _priority, _date} <- KralukKurkierewicz.Sitemap.entries() do
        html = conn |> get(path) |> html_response(200)
        [_, title] = Regex.run(~r{<title[^>]*>\s*(.*?)\s*</title>}s, html)
        title = title |> String.replace("&amp;", "&") |> String.replace("&#39;", "'")
        assert String.length(title) <= 70, "#{path}: #{title}"
      end
    end

    test "rozwód has its own page, title and H1", %{conn: conn} do
      html = conn |> get(~p"/uslugi/rozwod") |> html_response(200)
      assert html =~ "<title"
      assert html =~ "Adwokat rozwód Gdańsk"
      [_, h1] = Regex.run(~r{<h1[^>]*>(.*?)</h1>}s, html)
      assert h1 =~ "Rozwód"
      assert html =~ "600 zł"
      assert html =~ ~s(href="/uslugi/podzial-majatku")
    end

    test "every service page has a summary, an update date and links to related services",
         %{conn: conn} do
      for service <- KralukKurkierewicz.Services.list() do
        html = conn |> get(~p"/uslugi/#{service.slug}") |> html_response(200)
        assert html =~ ~s(id="w-skrocie")
        assert html =~ "Zaktualizowano:"
        assert length(KralukKurkierewicz.Services.summary(service)) in 2..5

        related = KralukKurkierewicz.Services.related(service)
        assert related != [] and Enum.all?(related, & &1), service.slug
        for other <- related, do: assert(html =~ ~s(href="/uslugi/#{other.slug}"))

        page = html |> json_ld_graph() |> Enum.find(&(&1["@type"] == "WebPage"))
        assert page["dateModified"]
      end
    end

    test "extended service pages name the reviewing lawyer", %{conn: conn} do
      html = conn |> get(~p"/uslugi/upadlosc-konsumencka") |> html_response(200)
      assert html =~ "Weryfikacja merytoryczna"
      page = html |> json_ld_graph() |> Enum.find(&(&1["@type"] == "WebPage"))
      assert page["reviewedBy"]["@id"] =~ "#michal-kurkierewicz"
    end

    test "partner page declines the other partner's name and lists only own services",
         %{conn: conn} do
      html = conn |> get(~p"/zespol/milena-kraluk") |> html_response(200)
      assert html =~ "Wraz z adw. Michałem Kurkierewiczem prowadzi"
      [_, own] = Regex.run(~r{id="member-services">(.*?)</ul>}s, html)
      assert own =~ ~s(href="/uslugi/rozwod")
      refute own =~ ~s(href="/uslugi/upadlosc-konsumencka")

      html = conn |> get(~p"/zespol/michal-kurkierewicz") |> html_response(200)
      assert html =~ "Wraz z adw. Mileną Kraluk prowadzi"
    end

    test "every service is on a partner profile and profiles agree with the page leads" do
      [milena, michal] = KralukKurkierewicz.Team.list()
      all = Enum.map(KralukKurkierewicz.Services.list(), & &1.slug)

      assert Enum.sort(Enum.uniq(milena.services ++ michal.services)) == Enum.sort(all)

      for slug <- all, member <- KralukKurkierewicz.Team.list() do
        leads = KralukKurkierewicz.ServiceDetails.leads(slug)
        if leads != [], do: assert(member.slug in leads == slug in member.services, slug)
      end
    end

    test "zawyżony metraż is handled by both partners", %{conn: conn} do
      html = conn |> get(~p"/uslugi/zawyzony-metraz") |> html_response(200)
      assert html =~ "Sprawy prowadzą"
      assert html =~ ~s(id="service-lead-milena-kraluk")
      assert html =~ ~s(id="service-lead-michal-kurkierewicz")

      page = html |> json_ld_graph() |> Enum.find(&(&1["@type"] == "WebPage"))
      assert length(page["reviewedBy"]) == 2

      profile = conn |> get(~p"/zespol/michal-kurkierewicz") |> html_response(200)
      [_, own] = Regex.run(~r{id="member-services">(.*?)</ul>}s, profile)
      assert own =~ ~s(href="/uslugi/zawyzony-metraz")
    end

    test "IndexNow key file is served and the payload lists recently changed pages",
         %{conn: conn} do
      file = KralukKurkierewicz.IndexNow.key_file()
      assert conn |> get("/" <> file) |> response(200) == String.trim_trailing(file, ".txt")

      body = KralukKurkierewicz.IndexNow.payload(~D[2026-11-22], "https://kkadwokat.pl")
      assert body.host == "kkadwokat.pl"
      assert "https://kkadwokat.pl/uslugi/rozwod" in body.urlList
      assert "https://kkadwokat.pl" in body.urlList
      refute "https://kkadwokat.pl/polityka-prywatnosci" in body.urlList
      assert KralukKurkierewicz.IndexNow.payload(~D[2100-01-01]) == nil
    end
  end
end
