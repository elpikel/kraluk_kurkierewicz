defmodule KralukKurkierewiczWeb.Layouts do
  @moduledoc """
  This module holds layouts and related functionality
  used by your application.
  """
  use KralukKurkierewiczWeb, :html

  # Embed all files in layouts/* within this module.
  # The default root.html.heex file contains the HTML
  # skeleton of your application, namely HTML headers
  # and other static content.
  embed_templates "layouts/*"

  @doc """
  Shows the flash group with standard titles and content.

  ## Examples

      <.flash_group flash={@flash} />
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.flash kind={:info} flash={@flash} />
      <.flash kind={:error} flash={@flash} />
    </div>
    """
  end

  @doc """
  Emits schema.org JSON-LD structured data for the firm and its partners.

  Rendered site-wide in the document head so search engines can build the
  local business / knowledge panel from a single source of truth.
  """
  def structured_data(assigns) do
    ~H"""
    <script type="application/ld+json">
      <%= Phoenix.HTML.raw(seo_json_ld()) %>
    </script>
    """
  end

  defp seo_json_ld do
    base = KralukKurkierewiczWeb.Endpoint.url()

    """
    {
      "@context": "https://schema.org",
      "@graph": [
        {
          "@type": "LegalService",
          "@id": "#{base}/#organization",
          "name": "Kraluk Kurkierewicz Adwokacka Spółka Partnerska",
          "url": "#{base}/",
          "image": "#{base}/apple-touch-icon.png",
          "telephone": "+48698359581",
          "priceRange": "$$",
          "address": {
            "@type": "PostalAddress",
            "streetAddress": "ul. Strzelecka 7B",
            "postalCode": "80-803",
            "addressLocality": "Gdańsk",
            "addressCountry": "PL"
          },
          "areaServed": { "@type": "Country", "name": "Polska" },
          "knowsLanguage": "pl",
          "contactPoint": [
            { "@type": "ContactPoint", "telephone": "+48698359581", "contactType": "customer service", "availableLanguage": "pl" },
            { "@type": "ContactPoint", "telephone": "+48793102489", "contactType": "customer service", "availableLanguage": "pl" }
          ],
          "member": [
            { "@id": "#{base}/#milena-kraluk" },
            { "@id": "#{base}/#michal-kurkierewicz" }
          ]
        },
        {
          "@type": "Attorney",
          "@id": "#{base}/#milena-kraluk",
          "name": "adw. Milena Kraluk",
          "jobTitle": "Adwokat, Partner",
          "worksFor": { "@id": "#{base}/#organization" },
          "url": "#{base}/",
          "areaServed": "Polska"
        },
        {
          "@type": "Attorney",
          "@id": "#{base}/#michal-kurkierewicz",
          "name": "adw. Michał Kurkierewicz",
          "jobTitle": "Adwokat, Partner",
          "worksFor": { "@id": "#{base}/#organization" },
          "url": "#{base}/",
          "areaServed": "Polska"
        }
      ]
    }
    """
  end
end
