defmodule KralukKurkierewiczWeb.PageHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use KralukKurkierewiczWeb, :html

  embed_templates "page_html/*"
  # Blog post bodies live one level down and are dispatched by `post_body/1`.
  embed_templates "page_html/posts/*"

  @doc """
  Renders a blog post's article body, dispatching on the post's slug to the
  matching embedded template under `page_html/posts/`.
  """
  attr :post, :map, required: true

  def post_body(%{post: %{slug: "kredyt-po-rozwodzie"}} = assigns) do
    kredyt_po_rozwodzie(assigns)
  end

  def post_body(%{post: %{slug: "upadlosc-konsumencka"}} = assigns) do
    upadlosc_konsumencka(assigns)
  end

  def post_body(%{post: %{slug: "wysokosc-alimentow-na-dziecko"}} = assigns) do
    wysokosc_alimentow_na_dziecko(assigns)
  end

  def post_body(%{post: %{slug: "zawyzony-metraz-scianki-dzialowe"}} = assigns) do
    zawyzony_metraz_scianki_dzialowe(assigns)
  end

  @doc """
  Mid-article consultation upsell, placed inside a post body template.

  The post body container styles every descendant `a`/`p`, so the button
  re-asserts its own colors with `!` overrides.
  """
  attr :title, :string, required: true
  slot :inner_block, required: true

  def post_cta(assigns) do
    ~H"""
    <aside
      class="my-9 rounded-[12px] border border-brass/45 bg-brass-soft/60 px-[clamp(1.1rem,3vw,1.75rem)] py-[clamp(1.1rem,2.6vw,1.5rem)] shadow-[inset_4px_0_0_var(--color-brass)]"
      aria-label="Konsultacja prawna"
    >
      <p class="m-0! font-display text-[1.3rem] leading-snug font-semibold text-ink">{@title}</p>
      <p class="mt-2! text-[.98rem] text-copy">{render_slot(@inner_block)}</p>
      <div class="mt-4 flex flex-wrap items-center gap-x-5 gap-y-3">
        <a
          class="btn border-[#bf9c6a]! px-[1.3rem] py-[.7rem] text-[.95rem] text-ink-deep! hover:border-[#bf9c6a]! max-sm:w-full max-sm:text-center plausible-event-name=CTA plausible-event-cel=Umow-spotkanie plausible-event-miejsce=Blog-srodek"
          href={~p"/#kontakt"}
        >
          Umów konsultację
        </a>
        <span class="text-[.92rem] text-muted">
          lub zadzwoń:
          <a
            class="plausible-event-name=Telefon plausible-event-miejsce=Blog-srodek"
            href="tel:+48698359581"
          >
            698 359 581
          </a>
          lub
          <a
            class="plausible-event-name=Telefon plausible-event-miejsce=Blog-srodek"
            href="tel:+48793102489"
          >
            793 102 489
          </a>
        </span>
      </div>
    </aside>
    """
  end

  @doc "Closing consultation upsell rendered after every blog post body and on service pages."
  attr :place, :string, default: "Blog-koniec", doc: "Plausible `miejsce` event property"

  def post_end_cta(assigns) do
    ~H"""
    <aside
      class="bg-contact relative mt-10 overflow-hidden rounded-[12px] p-[clamp(1.4rem,3.5vw,2.25rem)] text-cream"
      aria-labelledby="post-end-cta-title"
      id="post-end-cta"
    >
      <svg
        aria-hidden="true"
        class="pointer-events-none absolute -right-6 -bottom-8 h-44 w-auto text-brass opacity-15 max-sm:h-32"
        viewBox="0 0 1426 1448"
      >
        <use height="1448" href="#kk-crane" width="1426"></use>
      </svg>
      <div class="relative">
        <p class="m-0 text-[.82rem] font-semibold tracking-[.12em] text-brass uppercase">
          Potrzebujesz pomocy w podobnej sprawie?
        </p>
        <h2
          class="mt-2 mb-2 font-display text-[clamp(1.5rem,2.6vw,1.9rem)] text-cream"
          id="post-end-cta-title"
        >
          Umów konsultację z adwokatem
        </h2>
        <p class="max-w-[52ch] text-white/80">
          Przeanalizujemy Twoją sytuację, powiemy, czy możemy pomóc i ile to będzie kosztować.
          Konsultacje prowadzimy w Gdańsku, a także telefonicznie lub przez wideo.
        </p>
        <div class="mt-6 flex flex-wrap items-center gap-x-6 gap-y-4">
          <a
            class={"btn max-sm:w-full max-sm:text-center plausible-event-name=CTA plausible-event-cel=Umow-spotkanie plausible-event-miejsce=#{@place}"}
            href={~p"/#kontakt"}
          >
            Umów konsultację
          </a>
          <div class="flex flex-wrap gap-x-5 gap-y-2 text-[1.02rem] [&_a]:border-b [&_a]:border-brass/70 [&_a]:transition-colors [&_a:hover]:border-brass">
            <a
              class={"plausible-event-name=Telefon plausible-event-miejsce=#{@place}"}
              href="tel:+48698359581"
            >
              698 359 581
            </a>
            <a
              class={"plausible-event-name=Telefon plausible-event-miejsce=#{@place}"}
              href="tel:+48793102489"
            >
              793 102 489
            </a>
            <a href="mailto:kontakt@kkadwokat.pl">kontakt@kkadwokat.pl</a>
          </div>
        </div>
      </div>
    </aside>
    """
  end

  @months ~w(stycznia lutego marca kwietnia maja czerwca lipca sierpnia września października listopada grudnia)

  @doc "Formats a date in Polish, e.g. `22 listopada 2026`."
  def format_date_pl(%Date{day: day, month: month, year: year}) do
    "#{day} #{Enum.at(@months, month - 1)} #{year}"
  end

  @doc """
  Link to a legal act on ISAP (isap.sejm.gov.pl), for "Podstawa prawna" boxes.
  The link text is the act name unless an inner block is given.
  """
  attr :act, :atom, required: true, doc: "act key from `KralukKurkierewicz.Services` (e.g. :kro)"
  slot :inner_block

  def isap(assigns) do
    {name, url} = KralukKurkierewicz.Services.act(assigns.act)
    assigns = assign(assigns, name: name, url: url)

    ~H"""
    <a href={@url} rel="noopener" target="_blank">
      {if @inner_block != [], do: render_slot(@inner_block), else: @name}
    </a>
    """
  end

  @doc "Card linking a blog post to its practice-area page."
  attr :service, :map, required: true

  def service_link(assigns) do
    ~H"""
    <a
      class="group mt-9 flex items-center justify-between gap-5 rounded-[12px] border border-line bg-paper px-[clamp(1.1rem,3vw,1.6rem)] py-5 transition duration-200 hover:-translate-y-0.5 hover:border-brass/60 hover:shadow-card motion-reduce:transition-none motion-reduce:hover:translate-y-0"
      href={~p"/uslugi/#{@service.slug}"}
      id="post-service-link"
    >
      <span>
        <span class="block text-[.8rem] font-semibold tracking-[.12em] text-brass-deep uppercase">
          Jak możemy pomóc
        </span>
        <span class="mt-1 block font-display text-[1.35rem] leading-snug font-semibold text-ink">
          {@service.name}
        </span>
      </span>
      <span
        aria-hidden="true"
        class="grid size-10 flex-none place-items-center rounded-full border border-brass/50 text-brass-deep transition-transform duration-200 group-hover:translate-x-1 motion-reduce:transition-none"
      >
        →
      </span>
    </a>
    """
  end

  @doc "Author box with photo and bio, rendered after a blog post body."
  attr :author, :map, required: true

  def author_bio(assigns) do
    ~H"""
    <section
      aria-labelledby="autor-name"
      class="mt-9 grid grid-cols-[88px_1fr] items-start gap-5 border-t border-line pt-8 max-sm:grid-cols-[64px_1fr] max-sm:gap-4"
      id="autor"
    >
      <img
        src={@author.image}
        alt={@author.display_name}
        width="88"
        height="88"
        loading="lazy"
        decoding="async"
        class="aspect-square w-full rounded-full object-cover object-[50%_20%] ring-1 ring-line"
      />
      <div>
        <p class="m-0 text-[.8rem] font-semibold tracking-[.12em] text-brass-deep uppercase">
          O autorze
        </p>
        <h2
          class="mt-1 mb-2 font-display text-[1.45rem] leading-snug font-semibold text-ink"
          id="autor-name"
        >
          {@author.display_name}
        </h2>
        <p class="m-0 max-w-[60ch] text-[.98rem] leading-[1.7] text-muted">{@author.bio}</p>
        <a
          class="mt-3 inline-block text-[.92rem] font-semibold text-brass-deep transition-colors hover:text-ink"
          href={~p"/zespol/#{@author.slug}"}
        >
          Więcej o autorze i pozostałe artykuły →
        </a>
      </div>
    </section>
    """
  end

  @doc "One \"Specjalizacje\" column on the home page; every item links to its service page."
  attr :services, :list, required: true

  def specialization_list(assigns) do
    ~H"""
    <ul class="*:border-b *:border-line *:last:border-b-0">
      <li :for={service <- @services}>
        <a
          class="group relative block py-4 pl-[1.4rem] before:absolute before:top-6 before:left-0 before:size-[7px] before:rounded-full before:bg-brass before:shadow-[0_0_0_3px_rgba(207,174,126,.18)] before:transition-transform before:duration-200 hover:before:scale-125 motion-reduce:before:transition-none"
          href={~p"/uslugi/#{service.slug}"}
        >
          <h4 class="mb-[.2rem] flex items-baseline justify-between gap-3 text-[1.02rem] font-semibold text-ink transition-colors group-hover:text-brass-deep">
            {service.home_name}
            <span
              aria-hidden="true"
              class="flex-none text-brass opacity-60 transition duration-200 group-hover:translate-x-0.5 group-hover:opacity-100 motion-reduce:transition-none"
            >
              →
            </span>
          </h4>
          <p class="m-0 text-[.94rem] text-muted">{service.home_text}</p>
        </a>
      </li>
    </ul>
    """
  end

  @doc "The other partner (for cross-references on a partner's page)."
  def other_partner(member) do
    Enum.find(KralukKurkierewicz.Team.list(), &(&1.slug != member.slug))
  end

  @doc "\"Powiązane artykuły\" list rendered after a blog post."
  attr :posts, :list, required: true

  def related_posts(assigns) do
    ~H"""
    <section
      :if={@posts != []}
      aria-labelledby="related-title"
      class="mt-9 border-t border-line pt-8"
      id="related"
    >
      <h2 class="mb-4 font-display text-[1.45rem] font-semibold text-ink" id="related-title">
        Powiązane artykuły
      </h2>
      <ul class="grid gap-4 sm:grid-cols-2">
        <li :for={post <- @posts}>
          <a
            class="group block h-full rounded-[12px] border border-line bg-paper p-5 transition duration-200 hover:-translate-y-0.5 hover:border-brass/60 hover:shadow-card motion-reduce:transition-none motion-reduce:hover:translate-y-0"
            href={~p"/blog/#{post.slug}"}
          >
            <span class="block text-[.82rem] font-semibold text-brass-deep">{post.category}</span>
            <span class="mt-1 block font-display text-[1.2rem] leading-snug font-semibold text-ink transition-colors group-hover:text-brass-deep">
              {post.title}
            </span>
          </a>
        </li>
      </ul>
    </section>
    """
  end

  @doc """
  One long-form section of an extended service page. `blocks` come from
  `KralukKurkierewicz.ServiceDetails`: paragraph strings, `{:list, items}`,
  `{:rulings, [{text, label, url}]}` or `:calculator`.
  """
  attr :title, :string, required: true
  attr :blocks, :list, required: true

  def service_section(assigns) do
    ~H"""
    <h2 class="mt-12">{@title}</h2>
    <%= for block <- @blocks do %>
      <%= case block do %>
        <% text when is_binary(text) -> %>
          <p>{text}</p>
        <% {:list, items} -> %>
          <ul class="my-4 grid gap-2 pl-5 marker:text-brass [&>li]:list-disc [&>li]:leading-[1.7]">
            <li :for={item <- items}>{item}</li>
          </ul>
        <% {:rulings, rulings} -> %>
          <ul class="my-5 grid gap-4">
            <li
              :for={{text, label, url} <- rulings}
              class="rounded-[12px] border border-line-soft bg-paper px-5 py-4 text-[.98rem] leading-[1.7] shadow-[inset_3px_0_0_var(--color-brass)]"
            >
              {text}
              <a
                class="mt-2 block text-[.9rem] font-semibold text-brass-deep transition-colors hover:text-ink"
                href={url}
                rel="noopener"
                target="_blank"
              >
                {label} →
              </a>
            </li>
          </ul>
        <% :calculator -> %>
          <.overpayment_calculator />
      <% end %>
    <% end %>
    """
  end

  @doc """
  Overpayment calculator for the "zawyżony metraż" page: (contract area − real
  area) × price per m². Behaviour lives in `assets/js/app.js` (`#metraz-calc`);
  the result shown before any input matches the default example values.
  """
  def overpayment_calculator(assigns) do
    ~H"""
    <form
      class="my-6 rounded-[14px] border border-brass/45 bg-brass-soft/50 p-[clamp(1.1rem,3vw,1.75rem)]"
      id="metraz-calc"
      novalidate
    >
      <div class="grid gap-4 sm:grid-cols-3 lg:grid-cols-1 xl:grid-cols-3">
        <label class="flex flex-col justify-end gap-1 text-[.88rem] leading-snug font-semibold text-ink">
          Powierzchnia z umowy, m²
          <input
            class="rounded-lg border border-line bg-white px-3 py-[.65rem] text-[1rem] font-normal text-copy tabular-nums transition focus:border-brass focus:shadow-[0_0_0_3px_rgba(207,174,126,.28)] focus:outline-none"
            id="metraz-calc-contract"
            inputmode="decimal"
            name="contract"
            type="text"
            value="55,81"
          />
        </label>
        <label class="flex flex-col justify-end gap-1 text-[.88rem] leading-snug font-semibold text-ink">
          Bez ścianek działowych, m²
          <input
            class="rounded-lg border border-line bg-white px-3 py-[.65rem] text-[1rem] font-normal text-copy tabular-nums transition focus:border-brass focus:shadow-[0_0_0_3px_rgba(207,174,126,.28)] focus:outline-none"
            id="metraz-calc-real"
            inputmode="decimal"
            name="real"
            type="text"
            value="52,88"
          />
        </label>
        <label class="flex flex-col justify-end gap-1 text-[.88rem] leading-snug font-semibold text-ink">
          Cena za m², zł
          <input
            class="rounded-lg border border-line bg-white px-3 py-[.65rem] text-[1rem] font-normal text-copy tabular-nums transition focus:border-brass focus:shadow-[0_0_0_3px_rgba(207,174,126,.28)] focus:outline-none"
            id="metraz-calc-price"
            inputmode="decimal"
            name="price"
            type="text"
            value="7 433"
          />
        </label>
      </div>
      <div
        aria-live="polite"
        class="mt-5 flex flex-wrap items-baseline justify-between gap-x-6 gap-y-1 border-t border-brass/40 pt-4"
      >
        <span class="text-[.95rem] text-copy">
          Różnica powierzchni: <strong class="tabular-nums" id="metraz-calc-diff">2,93 m²</strong>
        </span>
        <span class="text-[.95rem] text-copy">
          Szacowana nadpłata:
          <strong
            class="ml-1 font-display text-[1.9rem] leading-none font-semibold text-ink tabular-nums"
            id="metraz-calc-result"
          >
            21 778,69 zł
          </strong>
        </span>
      </div>
      <p class="mt-2! text-[.82rem]! text-muted" id="metraz-calc-note">
        Przykładowe dane — wpisz wartości ze swojej umowy i pomiaru.
      </p>
    </form>
    """
  end
end
