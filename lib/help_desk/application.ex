defmodule HelpDesk.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HelpDeskWeb.Telemetry,
      HelpDesk.Repo,
      {DNSCluster, query: Application.get_env(:help_desk, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: HelpDesk.PubSub},
      # Start a worker by calling: HelpDesk.Worker.start_link(arg)
      # {HelpDesk.Worker, arg},
      # Start to serve requests, typically the last entry
      HelpDeskWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelpDesk.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HelpDeskWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
