defmodule KralukKurkierewiczWeb.StructuredData do
  @moduledoc """
  schema.org JSON-LD for the site.

  Every page emits one `@graph` in the document head: the firm (`LegalService`),
  both partners (`Person`) and the `WebSite`, plus page-specific nodes passed by
  the controller via the `:json_ld` assign (`faq_page/0`, `breadcrumbs/1`,
  `article/1`).

  Everything described here must also be visible on the page — keep the firm
  details in sync with the contact section of `home.html.heex`, and the FAQ
  entries below are rendered verbatim in the home page FAQ section.
  """

  @firm_name "Kraluk Kurkierewicz Adwokacka Spółka Partnerska"

  # Cities named in `areaServed`; `@area_sentence` below must list the same places.
  @area_cities ~w(Gdańsk Gdynia Sopot) ++
                 ["Pruszcz Gdański", "Tczew", "Wejherowo", "Rumia", "Reda", "Kartuzy"] ++
                 ["Starogard Gdański"]

  # One sentence about the service area, reused verbatim in the FAQ and /llms.txt.
  @area_sentence "Obsługujemy Klientów z Gdańska, Gdyni, Sopotu, Pruszcza Gdańskiego, Tczewa, Wejherowa, Rumi, Redy, Kartuz, Starogardu Gdańskiego i całego województwa pomorskiego, a sprawy prowadzimy także w innych regionach Polski."

  # Office location (OpenStreetMap building match for ul. Strzelecka 7B, 80-803 Gdańsk).
  @geo %{latitude: 54.352435, longitude: 18.6382}

  # Profiles describing the firm elsewhere: Google Business Profile, bar registry, etc.
  # Empty entries are simply omitted from the JSON-LD.
  @firm_same_as []

  @faq [
    {"Jak umówić konsultację z adwokatem?",
     "Zadzwoń pod numer 698 359 581 lub 793 102 489, napisz na kontakt@kkadwokat.pl albo skorzystaj z formularza kontaktowego. Spotykamy się w kancelarii przy ul. Strzeleckiej 7B w Gdańsku."},
    {"Czy można skorzystać z porady prawnej online?",
     "Tak. Prowadzimy e-porady przez telefon lub wideo — zadzwoń albo napisz, a ustalimy dogodny termin rozmowy."},
    {"Ile kosztuje prowadzenie sprawy?",
     "Koszt zależy od rodzaju i stopnia złożoności sprawy. Każdą współpracę rozpoczynamy od oceny sprawy — przed podjęciem działań przedstawiamy rekomendowany sposób działania, przewidywany czas trwania oraz koszty."},
    {"Jakimi sprawami zajmuje się kancelaria?",
     "Pomagamy osobom prywatnym w sprawach cywilnych, rodzinnych, spadkowych, odszkodowawczych, konsumenckich, w sporach z deweloperami i w upadłości konsumenckiej. Przedsiębiorcom zapewniamy bieżącą obsługę prawną, przygotowanie umów, windykację należności, reprezentację w sporach gospodarczych oraz wsparcie w zakresie RODO i nowych technologii."},
    {"Czy prowadzicie sprawy poza Gdańskiem?",
     "Tak. Kancelaria ma siedzibę w Gdańsku. " <> @area_sentence},
    {"Kto prowadzi sprawy w kancelarii?",
     "Kancelarię tworzą adwokat Milena Kraluk i adwokat Michał Kurkierewicz — absolwenci Wydziału Prawa i Administracji Uniwersytetu Gdańskiego, członkowie Pomorskiej Izby Adwokackiej w Gdańsku, z ponad 10-letnim doświadczeniem zawodowym."},
    {"W jakich godzinach pracuje kancelaria?",
     "Kancelaria pracuje od poniedziałku do piątku w godzinach 9:00–17:00."}
  ]

  @doc "FAQ entries as `{question, answer}` tuples, rendered on the home page."
  def faq, do: @faq

  @doc "Service-area sentence shared by the FAQ and /llms.txt."
  def area_sentence, do: @area_sentence

  @doc "`areaServed` value: the listed cities, województwo pomorskie and Polska."
  def area_served do
    Enum.map(@area_cities, &%{"@type" => "City", "name" => &1}) ++
      [
        %{"@type" => "AdministrativeArea", "name" => "województwo pomorskie"},
        %{"@type" => "Country", "name" => "Polska"}
      ]
  end

  # Drops `sameAs` when there are no profile URLs yet.
  defp put_same_as(node, []), do: node
  defp put_same_as(node, urls), do: Map.put(node, "sameAs", urls)

  @doc "Encodes the site graph plus `page_nodes` as an HTML-safe JSON string."
  def encode(page_nodes \\ []) do
    Jason.encode!(
      %{"@context" => "https://schema.org", "@graph" => site_nodes() ++ List.wrap(page_nodes)},
      escape: :html_safe
    )
  end

  defp base, do: KralukKurkierewiczWeb.Endpoint.url()
  defp org_id, do: base() <> "/#organization"

  defp site_nodes do
    base = base()

    [
      %{
        "@type" => "LegalService",
        "@id" => org_id(),
        "name" => @firm_name,
        "alternateName" => "Kraluk Kurkierewicz",
        "description" =>
          "Kancelaria adwokacka w Gdańsku. Sprawy cywilne, rodzinne, spadkowe, odszkodowania oraz obsługa prawna firm.",
        "url" => base <> "/",
        "logo" => base <> "/apple-touch-icon.png",
        "image" => base <> "/images/og-image.png",
        "telephone" => "+48698359581",
        "email" => "kontakt@kkadwokat.pl",
        "priceRange" => price_range(),
        "address" => %{
          "@type" => "PostalAddress",
          "streetAddress" => "ul. Strzelecka 7B",
          "postalCode" => "80-803",
          "addressLocality" => "Gdańsk",
          "addressRegion" => "pomorskie",
          "addressCountry" => "PL"
        },
        "openingHoursSpecification" => [
          %{
            "@type" => "OpeningHoursSpecification",
            "dayOfWeek" => ~w(Monday Tuesday Wednesday Thursday Friday),
            "opens" => "09:00",
            "closes" => "17:00"
          }
        ],
        "contactPoint" =>
          Enum.map(~w(+48698359581 +48793102489), fn phone ->
            %{
              "@type" => "ContactPoint",
              "telephone" => phone,
              "contactType" => "customer service",
              "availableLanguage" => "pl"
            }
          end),
        "geo" => %{
          "@type" => "GeoCoordinates",
          "latitude" => @geo.latitude,
          "longitude" => @geo.longitude
        },
        "areaServed" => area_served(),
        "knowsLanguage" => "pl",
        "employee" => [
          %{"@id" => person_id("milena-kraluk")},
          %{"@id" => person_id("michal-kurkierewicz")}
        ]
      }
      |> put_same_as(@firm_same_as)
    ] ++
      Enum.map(KralukKurkierewicz.Team.list(), &person/1) ++
      [
        %{
          "@type" => "WebSite",
          "@id" => base <> "/#website",
          "url" => base <> "/",
          "name" => "Kraluk Kurkierewicz — Kancelaria Adwokacka Gdańsk",
          "inLanguage" => "pl-PL",
          "publisher" => %{"@id" => org_id()}
        }
      ]
  end

  defp person_id(slug), do: base() <> "/#" <> slug

  defp person(%{slug: slug} = member) do
    %{
      "@type" => "Person",
      "@id" => person_id(slug),
      "name" => member.name,
      "honorificPrefix" => "adw.",
      "jobTitle" => "Adwokat, Partner",
      "description" => member.bio,
      "image" => base() <> member.image,
      "url" => base() <> "/zespol/" <> slug,
      "worksFor" => %{"@id" => org_id()},
      "alumniOf" => %{
        "@type" => "CollegeOrUniversity",
        "name" => "Uniwersytet Gdański, Wydział Prawa i Administracji"
      },
      "memberOf" => %{"@type" => "Organization", "name" => "Pomorska Izba Adwokacka w Gdańsku"},
      "knowsLanguage" => "pl"
    }
    |> put_same_as(member.same_as)
  end

  defp price_range do
    {min, max} = KralukKurkierewicz.Pricing.bounds()
    KralukKurkierewicz.Pricing.format_range(min, max)
  end

  @doc "`FAQPage` node for arbitrary `{question, answer}` pairs on `path`."
  def faq_page(entries, path) do
    %{
      "@type" => "FAQPage",
      "@id" => base() <> path <> "#faq",
      "mainEntity" =>
        Enum.map(entries, fn {question, answer} ->
          %{
            "@type" => "Question",
            "name" => question,
            "acceptedAnswer" => %{"@type" => "Answer", "text" => answer}
          }
        end)
    }
  end

  @doc "`ProfilePage` node for a partner's page."
  def profile_page(member) do
    url = base() <> "/zespol/" <> member.slug

    %{
      "@type" => "ProfilePage",
      "@id" => url,
      "url" => url,
      "name" => member.display_name,
      "inLanguage" => "pl-PL",
      "mainEntity" => %{"@id" => person_id(member.slug)},
      "isPartOf" => %{"@id" => base() <> "/#website"}
    }
  end

  @doc "`OfferCatalog` node for the price list."
  def offer_catalog(sections) do
    %{
      "@type" => "OfferCatalog",
      "@id" => base() <> "/cennik#cennik",
      "name" => "Cennik usług prawnych",
      "provider" => %{"@id" => org_id()},
      "itemListElement" =>
        for {_title, items} <- sections, {label, min, max, _service} <- items do
          %{
            "@type" => "Offer",
            "itemOffered" => %{"@type" => "Service", "name" => label},
            "priceSpecification" => %{
              "@type" => "PriceSpecification",
              "priceCurrency" => "PLN",
              "minPrice" => min,
              "maxPrice" => max,
              "valueAddedTaxIncluded" => true
            }
          }
        end
    }
  end

  @doc "`Service` node for a practice-area page."
  def service(service) do
    url = base() <> "/uslugi/" <> service.slug

    %{
      "@type" => "Service",
      "@id" => url <> "#service",
      "name" => service.name,
      "serviceType" => service.name,
      "description" => service.description,
      "url" => url,
      "provider" => %{"@id" => org_id()},
      "areaServed" => area_served()
    }
  end

  @doc """
  `WebPage` node for a practice-area page: last content update and, when a
  partner handles these cases, the reviewing lawyer (both visible on the page).
  """
  def service_page(service, %Date{} = updated, leads) do
    url = base() <> "/uslugi/" <> service.slug

    node = %{
      "@type" => "WebPage",
      "@id" => url,
      "url" => url,
      "name" => service.title,
      "inLanguage" => "pl-PL",
      "dateModified" => Date.to_iso8601(updated),
      "mainEntity" => %{"@id" => url <> "#service"},
      "isPartOf" => %{"@id" => base() <> "/#website"}
    }

    case Enum.map(leads, &%{"@id" => person_id(&1.slug)}) do
      [] -> node
      [reviewer] -> Map.put(node, "reviewedBy", reviewer)
      reviewers -> Map.put(node, "reviewedBy", reviewers)
    end
  end

  @doc "`FAQPage` node built from `faq/0`."
  def faq_page do
    %{
      "@type" => "FAQPage",
      "@id" => base() <> "/#faq",
      "mainEntity" =>
        Enum.map(@faq, fn {question, answer} ->
          %{
            "@type" => "Question",
            "name" => question,
            "acceptedAnswer" => %{"@type" => "Answer", "text" => answer}
          }
        end)
    }
  end

  @doc """
  `BreadcrumbList` node. `trail` is a list of `{name, path}` after the home page,
  e.g. `[{"Blog", "/blog"}, {post.title, "/blog/slug"}]`.
  """
  def breadcrumbs(trail) do
    items =
      [{"Strona główna", "/"} | trail]
      |> Enum.with_index(1)
      |> Enum.map(fn {{name, path}, position} ->
        %{"@type" => "ListItem", "position" => position, "name" => name, "item" => base() <> path}
      end)

    %{"@type" => "BreadcrumbList", "itemListElement" => items}
  end

  @doc "`Article` node for a blog post."
  def article(post) do
    url = base() <> "/blog/" <> post.slug

    %{
      "@type" => "Article",
      "@id" => url <> "#article",
      "mainEntityOfPage" => url,
      "url" => url,
      "headline" => post.title,
      "description" => post.description,
      "datePublished" => Date.to_iso8601(post.date),
      "dateModified" => Date.to_iso8601(KralukKurkierewicz.Blog.last_modified(post)),
      "articleSection" => post.category,
      "inLanguage" => "pl-PL",
      "image" => base() <> "/images/og-image.png",
      "author" => %{"@id" => person_id(post.author)},
      "publisher" => %{"@id" => org_id()},
      "isPartOf" => %{"@id" => base() <> "/#website"}
    }
  end
end
