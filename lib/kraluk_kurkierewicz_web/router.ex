defmodule KralukKurkierewiczWeb.Router do
  use KralukKurkierewiczWeb, :router

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {KralukKurkierewiczWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", KralukKurkierewiczWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/blog", PageController, :blog
    get "/blog/:slug", PageController, :blog_post
    get "/polityka-prywatnosci", PageController, :privacy
    get "/sitemap.xml", PageController, :sitemap
    post "/api/kontakt", PageController, :contact
  end

  # Analytics event proxy to avoid ad blockers (no pipeline: POST /api/event must skip CSRF).
  # The tracking script itself is a vendored static file at priv/static/js/stats.js.
  scope "/", KralukKurkierewiczWeb do
    post "/api/event", AnalyticsController, :event

    # Plain-text site summary for LLM crawlers (https://llmstxt.org); outside :browser so
    # a `text/plain`-only Accept header isn't rejected with 406.
    get "/llms.txt", PageController, :llms_txt
  end

  # Other scopes may use custom stacks.
  # scope "/api", KralukKurkierewiczWeb do
  #   pipe_through :api
  # end

  # Enable Swoosh mailbox preview in development
  if Application.compile_env(:kraluk_kurkierewicz, :dev_routes) do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
