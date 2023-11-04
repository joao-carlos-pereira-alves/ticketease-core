defmodule ReservaOnline.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ReservaOnlineWeb.Telemetry,
      ReservaOnline.Repo,
      {DNSCluster, query: Application.get_env(:reserva_online, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ReservaOnline.PubSub},
      # Start a worker by calling: ReservaOnline.Worker.start_link(arg)
      # {ReservaOnline.Worker, arg},
      # Start to serve requests, typically the last entry
      ReservaOnlineWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ReservaOnline.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ReservaOnlineWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
