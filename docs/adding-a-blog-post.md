# Jak dodać nowy wpis na blogu

Każdy wpis składa się z **trzech zmian w kodzie**. Wszystkie są statyczne (nie ma bazy
danych ani panelu CMS) — tekst artykułu i jego metadane żyją w plikach `.ex` / `.heex`.

Po dodaniu wpisu:

- jest automatycznie na liście `/blog` (od najnowszego),
- ma własny adres `/blog/<slug>`,
- trafia do `/sitemap.xml`,
- dostaje komplet tagów SEO (title, description, canonical, Open Graph, Twitter, JSON-LD) z layoutu.

---

## Pliki, które zmieniasz

| Plik | Co tu jest |
|---|---|
| `lib/kraluk_kurkierewicz/blog.ex` | Metadane wpisu (slug, tytuł, data, excerpt, SEO) |
| `lib/kraluk_kurkierewicz_web/controllers/page_html/posts/<slug_z_podkreslnikami>.html.heex` | Treść artykułu (HTML) |
| `lib/kraluk_kurkierewicz_web/controllers/page_html.ex` | Jedna linijka, która łączy slug z plikiem treści |

Routing, kontroler, layout i sitemap **działają automatycznie** — nic w nich nie zmieniasz.

---

## Krok 1 — Wybierz slug

Slug to końcówka adresu: `/blog/<slug>`.

Zasady:

- tylko małe litery ASCII, cyfry i myślniki — **bez polskich znaków** (`ł`, `ś`, `ą`…),
- zawrzyj główną frazę kluczową, np. `wysokosc-alimentow-na-dziecko`, `upadlosc-konsumencka`,
- slug jest trwały — po publikacji nie zmieniaj go (zmiana = inny adres i utrata pozycji w Google).

Z slugu powstaje też **nazwa pliku treści**: myślniki zamieniasz na podkreślniki.

```
slug:          upadlosc-konsumencka
plik treści:   upadlosc_konsumencka.html.heex
```

---

## Krok 2 — Utwórz plik z treścią

Utwórz plik:

```
lib/kraluk_kurkierewicz_web/controllers/page_html/posts/<slug_z_podkreslnikami>.html.heex
```

W środku piszesz **samą treść artykułu** (bez nagłówka, bez tytułu H1 — tytuł i lead
renderuje layout). Używaj prostego HTML:

```heex
<p>
  Pierwszy akapit treści (bez powtarzania excerptu — patrz niżej).
</p>

<h2>Nagłówek sekcji</h2>
<p>Akapit…</p>
<ul>
  <li>punkt listy;</li>
  <li>kolejny punkt.</li>
</ul>

<h2>Kolejna sekcja</h2>
<p>…</p>

<!-- Stopka z informacją prawną (na końcu każdego artykułu) -->
<p class="mt-5 text-[.86rem] text-muted italic">
  Stan prawny na <data> r. Artykuł ma charakter informacyjny i edukacyjny. Nie stanowi
  porady prawnej ani opinii prawnej w indywidualnej sprawie. Ocena konkretnej sytuacji
  wymaga analizy jej okoliczności i właściwych przepisów prawa.
</p>
```

Konwencje formatowania (dla spójności z istniejącymi wpisami):

- **Sekcje** → `<h2>`. Nie używaj `<h1>` (to jest tytuł wpisu, renderowany automatycznie).
- **Akapity** → `<p>`. **Listy** → `<ul><li>…`. Pogrubienie → `<strong>`.
- **Linki zewnętrzne** → `<a href="…" rel="noopener" target="_blank">…</a>`.
- Style (odstępy, kolory, wypunktowania) są narzucane globalnie przez kontener artykułu —
  nie trzeba dodawać klas do zwykłych `<p>`, `<h2>`, `<ul>`.
- Opcjonalny wyróżniony box (np. „Podstawa prawna") — skopiuj z istniejącego wpisu
  `wysokosc_alimentow_na_dziecko.html.heex`.

### ⚠️ Zasada: excerpt nie może się powtarzać w treści

Excerpt (patrz Krok 3) jest pokazywany **jako lead nad artykułem** oraz na karcie na liście
`/blog`. Jeśli ten sam tekst wstawisz też na początku treści, pojawi się **dwa razy**.

Dlatego: tekst, który dajesz do pola `excerpt`, **pomiń** w pliku treści — artykuł zaczynaj
od kolejnego akapitu.

---

## Krok 3 — Dodaj metadane w `blog.ex`

Dodaj nowy `%Post{}` na **górze** listy `@posts` (najnowszy wpis na początku):

```elixir
@posts [
  %Post{
    slug: "upadlosc-konsumencka",
    title: "Upadłość konsumencka - czy pozwala uwolnić się od długów?",
    meta_title: "Upadłość konsumencka - jak uwolnić się od długów?",
    date: ~D[2026-10-21],
    date_display: "21 października 2026",
    category: "Upadłość konsumencka",
    excerpt:
      "Pierwszy akapit / zajawka artykułu — pełnymi zdaniami…",
    description:
      "Opis do Google (meta description), ok. 120-155 znaków, najlepiej z pytaniem i zachętą."
  },
  # …poprzednie wpisy niżej
]
```

### Pola

| Pole | Wymagane | Opis |
|---|---|---|
| `slug` | ✅ | Końcówka adresu (Krok 1). Małe litery ASCII i myślniki. |
| `title` | ✅ | Tytuł H1 widoczny na stronie wpisu i jako nagłówek na liście. |
| `meta_title` | opcjonalne | Tytuł w zakładce przeglądarki i w wynikach Google (`<title>`). **Trzymaj ≤ ~60 znaków.** Gdy pominięte, używany jest `title` + „ — Kraluk Kurkierewicz". |
| `date` | ✅ | `~D[RRRR-MM-DD]`. Steruje kolejnością (najnowsze u góry) i `lastmod` w sitemapie. |
| `date_display` | ✅ | Data po polsku, np. `"21 października 2026"`. |
| `category` | ✅ | Etykieta tematyczna, np. `"Prawo rodzinne"`. |
| `excerpt` | ✅ | Zajawka — lead nad artykułem + tekst na karcie `/blog`. Pełne zdania. **Nie powielaj jej w treści.** |
| `description` | ✅ | Meta description do Google. Używana też w Open Graph i JSON-LD. |

> **Uwaga o `meta_title`/`title`:** jeśli ustawisz `meta_title`, trafia on do `<title>`
> **dokładnie** tak, jak go wpiszesz (bez dopisywania nazwy kancelarii). Dlatego pisz go
> zwięźle i z frazą kluczową na początku.

---

## Krok 4 — Połącz slug z plikiem treści (`page_html.ex`)

W `page_html.ex` dodaj klauzulę do `post_body/1`. Nazwa funkcji = nazwa pliku treści bez
rozszerzenia:

```elixir
def post_body(%{post: %{slug: "upadlosc-konsumencka"}} = assigns) do
  upadlosc_konsumencka(assigns)
end
```

(Dodaj ją nad istniejącymi klauzulami — kolejność nie ma znaczenia.)

---

## Krok 5 — Sprawdź

```bash
mix compile
```

Powinno skompilować się bez błędów. Szybka weryfikacja listy wpisów i wpisów do sitemapy:

```bash
mix run -e 'KralukKurkierewicz.Blog.list_posts() |> Enum.each(fn p -> IO.puts("/blog/#{p.slug}  #{Date.to_iso8601(p.date)}") end)'
```

Lokalnie odpal serwer i wejdź na `/blog` oraz `/blog/<slug>`:

```bash
mix phx.server
```

Sprawdź też:

- tytuł zakładki (`meta_title`) i opis w podglądzie (np. w devtools: `<meta name="description">`),
- czy excerpt **nie** powtarza się na początku artykułu,
- czy wpis jest w `/sitemap.xml`.

---

## SEO — co dzieje się automatycznie

Layout (`components/layouts/root.html.heex`) i kontroler generują dla każdego wpisu:

- `<title>` z `meta_title` (lub `title`),
- `<meta name="description">` z `description`,
- `<link rel="canonical">` na `/blog/<slug>`,
- Open Graph i Twitter Card (tytuł, opis, URL, obraz `og-image.png`),
- JSON-LD `BlogPosting` (nagłówek, opis, data, kategoria, autor/wydawca).

### Frazy kluczowe — gdzie je umieszczać

**Nie ma** pola `keywords` ani tagu `<meta name="keywords">` — został świadomie usunięty,
bo Google i inne duże wyszukiwarki całkowicie go ignorują (to martwy tag). Nie dodawaj go
z powrotem.

To **nie znaczy**, że frazy kluczowe są nieważne — po prostu umieszcza się je tam, gdzie
wyszukiwarki faktycznie je czytają:

- w **`meta_title`** (fraza główna najlepiej na początku),
- w **`title`** (H1),
- w **`description`**,
- w **nagłówkach `<h2>`** i naturalnie w **treści** artykułu.

Przykład: dla frazy „wysokość alimentów na dziecko" slug to `wysokosc-alimentow-na-dziecko`,
a fraza pojawia się w `meta_title`, tytule i nagłówkach — i to daje efekt SEO, a nie lista
słów w ukrytym tagu.

Po wdrożeniu nowego wpisu warto w Google Search Console poprosić o zindeksowanie nowego
adresu i ewentualnie ponownie przesłać sitemapę.

---

## Ściąga (checklist)

- [ ] Slug: małe litery ASCII + myślniki, z frazą kluczową.
- [ ] Plik treści `posts/<slug_z_podkreslnikami>.html.heex` — `<h2>` na sekcje, stopka prawna na końcu.
- [ ] Excerpt **pominięty** w treści (żeby się nie dublował).
- [ ] `%Post{}` na górze `@posts` w `blog.ex` z kompletem pól.
- [ ] `meta_title` ≤ ~60 znaków, fraza kluczowa z przodu.
- [ ] Klauzula `post_body/1` w `page_html.ex`.
- [ ] `mix compile` bez błędów; sprawdzone `/blog` i `/blog/<slug>`.
