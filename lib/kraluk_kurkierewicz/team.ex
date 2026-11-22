defmodule KralukKurkierewicz.Team do
  @moduledoc """
  The firm's partners — single source for blog bylines, author bios and the
  `Person` JSON-LD. Bio facts mirror the "Zespół" section of the home page.
  """

  @members %{
    "milena-kraluk" => %{
      slug: "milena-kraluk",
      name: "Milena Kraluk",
      display_name: "adw. Milena Kraluk",
      role: "Partner, adwokat",
      image: "/images/milena-kraluk.webp",
      # Date of the last change to this partner's page (sitemap `lastmod`).
      updated: ~D[2026-11-22],
      # Profile URLs for JSON-LD `sameAs`, e.g. the rejestradwokatow.pl entry.
      same_as: ["https://rejestradwokatow.pl/adwokat/kraluk-milena-83554"],
      bio:
        "Adwokat i partner w Kancelarii Kraluk Kurkierewicz. Absolwentka Wydziału Prawa i Administracji Uniwersytetu Gdańskiego, członkini Pomorskiej Izby Adwokackiej w Gdańsku. Ma ponad 10-letnie doświadczenie zawodowe."
    },
    "michal-kurkierewicz" => %{
      slug: "michal-kurkierewicz",
      name: "Michał Kurkierewicz",
      display_name: "adw. Michał Kurkierewicz",
      role: "Partner, adwokat",
      image: "/images/michal-kurkierewicz.webp",
      # Date of the last change to this partner's page (sitemap `lastmod`).
      updated: ~D[2026-11-22],
      # Profile URLs for JSON-LD `sameAs`, e.g. the rejestradwokatow.pl entry.
      same_as: ["https://rejestradwokatow.pl/adwokat/kurkierewicz-micha-81186"],
      bio:
        "Adwokat i partner w Kancelarii Kraluk Kurkierewicz. Absolwent Wydziału Prawa i Administracji Uniwersytetu Gdańskiego, członek Pomorskiej Izby Adwokackiej w Gdańsku. Ma ponad 10-letnie doświadczenie zawodowe."
    }
  }

  @doc "All partners, in display order."
  def list, do: [get!("milena-kraluk"), get!("michal-kurkierewicz")]

  @doc "A partner by slug; raises for unknown slugs so typos fail at compile/test time."
  def get!(slug), do: Map.fetch!(@members, slug)
end
