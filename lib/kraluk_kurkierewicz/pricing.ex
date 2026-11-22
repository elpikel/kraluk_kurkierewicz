defmodule KralukKurkierewicz.Pricing do
  @moduledoc """
  Indicative price ranges (gross, PLN) shown on `/cennik`, in each service
  page's FAQ and summarised in the `LegalService.priceRange`.

  Ranges were set from 2026 market averages for Gdańsk/Tricity (pricing portals
  and published law-firm price lists) and are a starting point for the
  partners to adjust. Prices are gross because the page addresses consumers.
  """

  # General services, not tied to a single practice area.
  @general [
    {"Konsultacja prawna (do 60 min, w kancelarii, telefonicznie lub wideo)", 250, 450},
    {"Stawka godzinowa", 300, 500},
    {"Pismo, wezwanie do zapłaty lub odpowiedź na pismo", 300, 800},
    {"Pisemna opinia prawna", 800, 2500}
  ]

  # Per service slug: `{label, min, max}` for representation in the first instance
  # unless stated otherwise.
  @by_service %{
    "sprawy-o-zaplate" => [{"Sprawa o zapłatę (I instancja)", 2500, 8000}],
    "odszkodowania" => [{"Sprawa o odszkodowanie lub zadośćuczynienie (I instancja)", 3000, 9000}],
    "zawyzony-metraz" => [{"Roszczenie o zwrot części ceny od dewelopera", 3000, 6000}],
    "nieruchomosci" => [
      {"Zasiedzenie, służebność lub zniesienie współwłasności", 3000, 10_000}
    ],
    "rozwod" => [
      {"Rozwód bez orzekania o winie", 3000, 5000},
      {"Rozwód z orzekaniem o winie", 6000, 12_000}
    ],
    "sprawy-rodzinne" => [{"Sprawa o alimenty", 2500, 5000}],
    "podzial-majatku" => [{"Podział majątku wspólnego", 4000, 15_000}],
    "prawa-konsumentow" => [{"Spór z przedsiębiorcą (I instancja)", 2000, 6000}],
    "upadlosc-konsumencka" => [
      {"Wniosek o ogłoszenie upadłości konsumenckiej", 2500, 4000},
      {"Wniosek wraz z prowadzeniem postępowania", 4000, 7000}
    ],
    "sprawy-spadkowe" => [
      {"Stwierdzenie nabycia spadku", 1500, 3000},
      {"Dział spadku lub sprawa o zachowek", 4000, 12_000}
    ],
    "prawo-karne" => [
      {"Postępowanie przygotowawcze", 3000, 8000},
      {"Postępowanie sądowe (I instancja)", 4000, 10_000}
    ],
    "obsluga-przedsiebiorcow" => [{"Stała obsługa prawna (miesięcznie)", 1500, 6000}],
    "zakladanie-spolek" => [{"Założenie i rejestracja spółki", 1500, 4000}],
    "umowy" => [{"Przygotowanie lub weryfikacja umowy", 800, 3500}],
    "egzekucja-wierzytelnosci" => [
      {"Uzyskanie nakazu zapłaty i wniosek egzekucyjny", 1500, 5000}
    ],
    "restrukturyzacja" => [{"Wsparcie w postępowaniu restrukturyzacyjnym", 8000, 30_000}],
    "obsluga-korporacyjna" => [{"Zmiany korporacyjne i wpis do KRS", 1500, 5000}],
    "nowe-technologie" => [{"Ocena prawna wdrożenia AI lub umowa IT", 2000, 8000}],
    "sukcesja-firm" => [{"Plan sukcesji wraz z dokumentami", 5000, 20_000}],
    "prawo-medyczne" => [{"Dokumentacja i umowy podmiotu leczniczego", 2500, 10_000}],
    "spory-gospodarcze" => [{"Spór gospodarczy (I instancja)", 5000, 20_000}],
    "rodo" => [
      {"Wdrożenie RODO", 3000, 10_000},
      {"Audyt zgodności z RODO", 2500, 8000}
    ]
  }

  @notes [
    "Podane kwoty są orientacyjne i zawierają podatek VAT.",
    "Dokładną wycenę przedstawiamy po zapoznaniu się ze sprawą — zależy ona od jej złożoności, wartości przedmiotu sporu i przewidywanego nakładu pracy. Wynagrodzenie może być ustalone ryczałtowo lub według stawki godzinowej.",
    "Kwoty nie obejmują opłat sądowych, kosztów biegłych, opłat skarbowych ani wydatków komorniczych.",
    "Wynagrodzenie za prowadzenie sprawy w II instancji ustalamy odrębnie."
  ]

  @doc "Date of the last change to the price list (sitemap `lastmod`); bump when prices change."
  def updated, do: ~D[2026-11-22]

  def general, do: @general
  def notes, do: @notes

  @doc "Price items for a service slug (`[]` if none)."
  def for_service(slug), do: Map.get(@by_service, slug, [])

  @doc "Lowest and highest price across the whole list."
  def bounds do
    all = @general ++ Enum.flat_map(@by_service, fn {_slug, items} -> items end)
    {all |> Enum.map(&elem(&1, 1)) |> Enum.min(), all |> Enum.map(&elem(&1, 2)) |> Enum.max()}
  end

  @doc ~S|Formats a range, e.g. `"2 500–5 000 zł"`.|
  def format_range(min, max), do: "#{format_pln(min)}–#{format_pln(max)} zł"

  @doc "Formats a whole złoty amount with a thin space thousands separator."
  def format_pln(amount) do
    amount
    |> Integer.to_string()
    |> String.reverse()
    |> String.replace(~r/(\d{3})(?=\d)/, "\\1 ")
    |> String.reverse()
  end

  @doc "FAQ answer about price for a service page."
  def faq_answer(slug) do
    items =
      Enum.map_join(for_service(slug), "; ", fn {label, min, max} ->
        "#{label}: #{format_range(min, max)}"
      end)

    "Orientacyjnie (z VAT): #{items}. Dokładną wycenę przedstawiamy po zapoznaniu się ze sprawą. Kwoty nie obejmują opłat sądowych i innych kosztów postępowania."
  end
end
