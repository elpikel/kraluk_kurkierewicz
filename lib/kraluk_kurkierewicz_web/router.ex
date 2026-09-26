defmodule KralukKurkierewiczWeb.Router do
  use KralukKurkierewiczWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
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
  end

  # Analytics event proxy to avoid ad blockers (no pipeline: POST /api/event must skip CSRF).
  # The tracking script itself is a vendored static file at priv/static/js/stats.js.
  scope "/", KralukKurkierewiczWeb do
    post "/api/event", AnalyticsController, :event
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
