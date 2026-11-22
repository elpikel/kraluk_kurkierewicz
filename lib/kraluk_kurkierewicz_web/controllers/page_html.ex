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

  @doc "Closing consultation upsell rendered after every blog post body."
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
            class="btn max-sm:w-full max-sm:text-center plausible-event-name=CTA plausible-event-cel=Umow-spotkanie plausible-event-miejsce=Blog-koniec"
            href={~p"/#kontakt"}
          >
            Umów konsultację
          </a>
          <div class="flex flex-wrap gap-x-5 gap-y-2 text-[1.02rem] [&_a]:border-b [&_a]:border-brass/70 [&_a]:transition-colors [&_a:hover]:border-brass">
            <a
              class="plausible-event-name=Telefon plausible-event-miejsce=Blog-koniec"
              href="tel:+48698359581"
            >
              698 359 581
            </a>
            <a
              class="plausible-event-name=Telefon plausible-event-miejsce=Blog-koniec"
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
end
