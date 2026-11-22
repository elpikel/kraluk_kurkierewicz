defmodule KralukKurkierewicz.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children =
      [KralukKurkierewiczWeb.Telemetry] ++
        repo_children() ++
        [
          {DNSCluster,
           query: Application.get_env(:kraluk_kurkierewicz, :dns_cluster_query) || :ignore},
          {Phoenix.PubSub, name: KralukKurkierewicz.PubSub},
          # Start a worker by calling: KralukKurkierewicz.Worker.start_link(arg)
          # {KralukKurkierewicz.Worker, arg},
          # Start to serve requests, typically the last entry
          KralukKurkierewiczWeb.Endpoint
        ] ++ index_now_children()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KralukKurkierewicz.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Production only (config/runtime.exs): tell IndexNow about pages changed by this deploy.
  defp index_now_children do
    if Application.get_env(:kraluk_kurkierewicz, :index_now, false) do
      [{Task, &KralukKurkierewicz.IndexNow.submit_recent/0}]
    else
      []
    end
  end

  # Only start the Repo when a database is actually configured. This app runs
  # without a database in production (see config/runtime.exs and the Dockerfile);
  # dev and test configure the Repo, so it starts there.
  defp repo_children do
    case Application.get_env(:kraluk_kurkierewicz, KralukKurkierewicz.Repo) do
      config when is_list(config) ->
        if config[:database], do: [KralukKurkierewicz.Repo], else: []

      _ ->
        []
    end
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    KralukKurkierewiczWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
