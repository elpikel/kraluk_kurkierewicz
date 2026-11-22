defmodule KralukKurkierewicz.Sitemap do
  @moduledoc """
  Every public page with its sitemap priority and `lastmod`.

  Each `lastmod` is a date stored next to that page's content (`Services.updated/1`,
  `ServiceDetails`, `Team`, `Pricing`, `Blog`) — never the deploy date. Bump it when
  the page copy changes so the signal stays trustworthy to crawlers; IndexNow
  (`KralukKurkierewicz.IndexNow`) resubmits pages by the same dates.
  """

  alias KralukKurkierewicz.Blog
  alias KralukKurkierewicz.Pricing
  alias KralukKurkierewicz.Services
  alias KralukKurkierewicz.Team

  @doc "`{path, priority, lastmod}` for every page; `lastmod` is a `Date`."
  def entries do
    services =
      Enum.map(Services.list(), &{"/uslugi/#{&1.slug}", "0.8", Services.updated(&1)})

    team = Enum.map(Team.list(), &{"/zespol/#{&1.slug}", "0.6", &1.updated})
    posts = Enum.map(Blog.list_posts(), &{"/blog/#{&1.slug}", "0.6", Blog.last_modified(&1)})

    [{"/", "1.0", ~D[2026-11-22]}, {"/blog", "0.7", ~D[2026-11-22]}] ++
      services ++
      [{"/cennik", "0.7", Pricing.updated()}] ++
      team ++ posts ++ [{"/polityka-prywatnosci", "0.5", ~D[2026-09-23]}]
  end
end
