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
     "Tak. Kancelaria ma siedzibę w Gdańsku i świadczy pomoc prawną na terenie całego kraju."},
    {"Kto prowadzi sprawy w kancelarii?",
     "Kancelarię tworzą adwokat Milena Kraluk i adwokat Michał Kurkierewicz — absolwenci Wydziału Prawa i Administracji Uniwersytetu Gdańskiego, członkowie Pomorskiej Izby Adwokackiej w Gdańsku, z ponad 10-letnim doświadczeniem zawodowym."},
    {"W jakich godzinach pracuje kancelaria?",
     "Kancelaria pracuje od poniedziałku do piątku w godzinach 9:00–17:00."}
  ]

  @doc "FAQ entries as `{question, answer}` tuples, rendered on the home page."
  def faq, do: @faq

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
        "priceRange" => "$$",
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
        "areaServed" => %{"@type" => "Country", "name" => "Polska"},
        "knowsLanguage" => "pl",
        "employee" => [
          %{"@id" => person_id("milena-kraluk")},
          %{"@id" => person_id("michal-kurkierewicz")}
        ]
      },
      person("milena-kraluk", "Milena Kraluk"),
      person("michal-kurkierewicz", "Michał Kurkierewicz"),
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

  defp person(slug, name) do
    %{
      "@type" => "Person",
      "@id" => person_id(slug),
      "name" => name,
      "honorificPrefix" => "adw.",
      "jobTitle" => "Adwokat, Partner",
      "image" => base() <> "/images/#{slug}.webp",
      "url" => base() <> "/#zespol",
      "worksFor" => %{"@id" => org_id()},
      "alumniOf" => %{
        "@type" => "CollegeOrUniversity",
        "name" => "Uniwersytet Gdański, Wydział Prawa i Administracji"
      },
      "memberOf" => %{"@type" => "Organization", "name" => "Pomorska Izba Adwokacka w Gdańsku"},
      "knowsLanguage" => "pl"
    }
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
    date = Date.to_iso8601(post.date)

    %{
      "@type" => "Article",
      "@id" => url <> "#article",
      "mainEntityOfPage" => url,
      "url" => url,
      "headline" => post.title,
      "description" => post.description,
      "datePublished" => date,
      "dateModified" => date,
      "articleSection" => post.category,
      "inLanguage" => "pl-PL",
      "image" => base() <> "/images/og-image.png",
      "author" => %{"@id" => org_id()},
      "publisher" => %{"@id" => org_id()},
      "isPartOf" => %{"@id" => base() <> "/#website"}
    }
  end
end
