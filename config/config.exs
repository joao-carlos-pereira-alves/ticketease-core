# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :reserva_online,
  ecto_repos: [ReservaOnline.Repo],
  generators: [timestamp_type: :utc_datetime]

# I18n config
config :reserva_online, ReservaOnline.Gettext, default_locale: "pt_BR", locales: ~w(pt_BR en)

# Configures the endpoint
config :reserva_online, ReservaOnlineWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [json: ReservaOnlineWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: ReservaOnline.PubSub,
  live_view: [signing_salt: "XrLwniMh"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
