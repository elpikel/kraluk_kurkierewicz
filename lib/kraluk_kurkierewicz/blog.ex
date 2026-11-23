defmodule KralukKurkierewicz.Blog.Post do
  @moduledoc "A single blog post's metadata."
  @enforce_keys [:slug, :title, :date, :date_display, :category, :excerpt, :description, :author]
  defstruct [
    :slug,
    :title,
    :date,
    :date_display,
    :category,
    :excerpt,
    :description,
    :meta_title,
    # `KralukKurkierewicz.Team` slug
    :author,
    # Date of the last substantive content change; nil when never updated.
    :updated,
    # `KralukKurkierewicz.Services` slug the post links to
    :service
  ]
end

defmodule KralukKurkierewicz.Blog do
  @moduledoc """
  Static blog content.

  Each post's display metadata lives here; the article body lives in a matching
  template under `page_html/posts/<slug_with_underscores>.html.heex` and is
  dispatched by `KralukKurkierewiczWeb.PageHTML.post_body/1`.

  To add a post: add a `%Post{}` entry below, create its body template, and add a
  matching clause to `post_body/1`. When you substantively change a published
  post, set `updated:` to that day — it is shown under the title and used for
  `dateModified` and the sitemap `lastmod`.
  """

  alias KralukKurkierewicz.Blog.Post

  @posts [
    %Post{
      slug: "kredyt-po-rozwodzie",
      author: "milena-kraluk",
      updated: ~D[2026-11-22],
      service: "podzial-majatku",
      title: "Kredyt hipoteczny po rozwodzie – co z ratami i mieszkaniem?",
      meta_title: "Kredyt po rozwodzie – podział majątku i hipoteka",
      date: ~D[2026-11-04],
      date_display: "4 listopada 2026",
      category: "Prawo rodzinne",
      excerpt:
        "Co dzieje się ze wspólnym kredytem po rozwodzie? Czy były małżonek, który otrzymał mieszkanie, musi sam spłacać raty? Czy można domagać się zwrotu spłaconych rat kredytu od byłego małżonka? Jak ustalić wartość mieszkania obciążonego hipoteką?",
      description:
        "Kredyt po rozwodzie – kto spłaca raty? Jak wygląda podział majątku, wycena mieszkania z hipoteką i rozliczenie kredytu? Sprawdź, jakie są możliwości prawne."
    },
    %Post{
      slug: "upadlosc-konsumencka",
      author: "michal-kurkierewicz",
      updated: ~D[2026-11-22],
      service: "upadlosc-konsumencka",
      title: "Upadłość konsumencka – czy pozwala uwolnić się od długów?",
      meta_title: "Upadłość konsumencka – jak uwolnić się od długów?",
      date: ~D[2026-10-21],
      date_display: "21 października 2026",
      category: "Upadłość konsumencka",
      excerpt:
        "Osoby, które dotąd terminowo regulowały swoje zobowiązania, mogą z czasem utracić możliwość ich dalszej spłaty. Przyczyną bywa utrata pracy, choroba lub zmiana sytuacji rodzinnej. Gdy raty i zaległe rachunki zaczynają przekraczać możliwości domowego budżetu, pojawiają się pytania o przyszłość: co stanie się z mieszkaniem, jaka część dochodów pozostanie na utrzymanie i czy istnieje możliwość umorzenia długów?",
      description:
        "Czym jest upadłość konsumencka i które długi można umorzyć? Dowiedz się, co dzieje się z mieszkaniem i dochodami oraz jak przygotować wniosek o oddłużenie."
    },
    %Post{
      slug: "wysokosc-alimentow-na-dziecko",
      author: "milena-kraluk",
      updated: ~D[2026-11-22],
      service: "alimenty",
      title: "Ile wynoszą alimenty na dziecko i jak sąd ustala ich wysokość?",
      meta_title: "Wysokość alimentów na dziecko – jak ją ustalić?",
      date: ~D[2026-10-20],
      date_display: "20 października 2026",
      category: "Prawo rodzinne",
      excerpt:
        "Ile alimentów można uzyskać na dziecko? Czy istnieje minimalna kwota alimentów? Co sąd bierze pod uwagę, ustalając wysokość świadczenia? Czy sąd bierze pod uwagę faktyczne zarobki rodziców, a może również czas, jaki każdy z rodziców poświęca na opiekę? To pytania, które często zadają nam Klienci przy okazji konsultacji w sprawie rozwodowej czy alimentacyjnej.",
      description:
        "Od czego zależy wysokość alimentów? Dowiedz się, jak sąd ocenia potrzeby dziecka, możliwości rodziców i koszty utrzymania."
    },
    %Post{
      slug: "zawyzony-metraz-scianki-dzialowe",
      meta_title: "Zawyżony metraż przez ścianki działowe – zwrot części ceny",
      author: "milena-kraluk",
      updated: ~D[2026-11-22],
      service: "zawyzony-metraz",
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

  @doc "Date of the last content change (update date, falling back to publication)."
  def last_modified(%Post{updated: nil, date: date}), do: date
  def last_modified(%Post{updated: updated}), do: updated

  @doc "Posts linked to the given service slug, newest first."
  def posts_for_service(service), do: Enum.filter(list_posts(), &(&1.service == service))

  @doc "Posts by the given author slug, newest first."
  def posts_by_author(author), do: Enum.filter(list_posts(), &(&1.author == author))

  @doc """
  Up to `limit` other posts related to `post`: same service first, then same
  category, then the newest remaining ones.
  """
  def related(%Post{} = post, limit \\ 2) do
    others = Enum.reject(list_posts(), &(&1.slug == post.slug))

    rank = fn other ->
      cond do
        post.service && other.service == post.service -> 0
        other.category == post.category -> 1
        true -> 2
      end
    end

    others
    |> Enum.with_index()
    |> Enum.sort_by(fn {other, index} -> {rank.(other), index} end)
    |> Enum.take(limit)
    |> Enum.map(&elem(&1, 0))
  end

  @doc "Fetch a single post by slug, or `nil` when it does not exist."
  def get_post(slug), do: Enum.find(@posts, &(&1.slug == slug))
end
