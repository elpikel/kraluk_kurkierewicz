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

  def post_body(%{post: %{slug: "zawyzony-metraz-scianki-dzialowe"}} = assigns) do
    zawyzony_metraz_scianki_dzialowe(assigns)
  end

  @doc """
  Builds schema.org `BlogPosting` JSON-LD for a post as an encoded string.
  """
  def blog_post_json_ld(post) do
    base = KralukKurkierewiczWeb.Endpoint.url()
    url = base <> "/blog/" <> post.slug
    image = base <> "/images/og-image.png"

    org = %{
      "@type" => "Organization",
      "name" => "Kraluk Kurkierewicz Adwokacka Spółka Partnerska",
      "url" => base <> "/"
    }

    Jason.encode!(%{
      "@context" => "https://schema.org",
      "@type" => "BlogPosting",
      "@id" => url,
      "mainEntityOfPage" => url,
      "url" => url,
      "headline" => post.title,
      "description" => post.description,
      "datePublished" => Date.to_iso8601(post.date),
      "dateModified" => Date.to_iso8601(post.date),
      "articleSection" => post.category,
      "inLanguage" => "pl",
      "image" => image,
      "author" => org,
      "publisher" => Map.put(org, "logo", %{"@type" => "ImageObject", "url" => image})
    })
  end
end
