defmodule KralukKurkierewicz.Blog.Post do
  @moduledoc "A single blog post's metadata."
  @enforce_keys [:slug, :title, :date, :date_display, :category, :excerpt, :description]
  defstruct [:slug, :title, :date, :date_display, :category, :excerpt, :description]
end

defmodule KralukKurkierewicz.Blog do
  @moduledoc """
  Static blog content.

  Each post's display metadata lives here; the article body lives in a matching
  template under `page_html/posts/<slug_with_underscores>.html.heex` and is
  dispatched by `KralukKurkierewiczWeb.PageHTML.post_body/1`.

  To add a post: add a `%Post{}` entry below, create its body template, and add a
  matching clause to `post_body/1`.
  """

  alias KralukKurkierewicz.Blog.Post

  @posts [
    %Post{
      slug: "zawyzony-metraz-scianki-dzialowe",
      title: "Zawyżony metraż przez ścianki działowe. Czy można odzyskać część ceny mieszkania?",
      date: ~D[2026-09-23],
      date_display: "23 września 2026",
      category: "Spory z deweloperami",
      excerpt:
        "Część deweloperów wliczała do powierzchni użytkowej lokalu powierzchnię zajętą przez ścianki działowe. Wyjaśniamy, jak do tego problemu podchodzą sądy, co zmieniła nowelizacja ustawy deweloperskiej i kiedy nabywca może domagać się zwrotu nadpłaconej części ceny.",
      description:
        "Kiedy nabywca mieszkania może odzyskać część ceny za metry zajęte przez ścianki działowe — orzecznictwo sądów, norma PN-ISO 9836 i nowelizacja ustawy deweloperskiej."
    }
  ]

  @doc "All posts, newest first."
  def list_posts, do: Enum.sort_by(@posts, & &1.date, {:desc, Date})

  @doc "Fetch a single post by slug, or `nil` when it does not exist."
  def get_post(slug), do: Enum.find(@posts, &(&1.slug == slug))
end
