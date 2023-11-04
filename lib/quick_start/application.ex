defmodule QuickStart.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      QuickStartWeb.Telemetry,
      QuickStart.Repo,
      {DNSCluster, query: Application.get_env(:quick_start, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: QuickStart.PubSub},
      # Start a worker by calling: QuickStart.Worker.start_link(arg)
      # {QuickStart.Worker, arg},
      # Start to serve requests, typically the last entry
      QuickStartWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: QuickStart.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    QuickStartWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
