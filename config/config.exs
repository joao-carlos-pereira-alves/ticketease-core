# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :help_desk,
  ecto_repos: [HelpDesk.Repo],
  generators: [timestamp_type: :utc_datetime]

# I18n config
config :help_desk, HelpDesk.Gettext, default_locale: "pt_BR", locales: ~w(pt_BR en)

# Configures the endpoint
config :help_desk, HelpDeskWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [json: HelpDeskWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: HelpDesk.PubSub,
  live_view: [signing_salt: "XrLwniMh"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :help_desk, HelpDesk.Guardian,
       issuer: "help_desk",
       secret_key: "cO7dtNIzHNh0xfVsWxy1ONnrEuc5U8kT9gCj6/1lgJrdzWgOxmQLYWQgx368FoBp",
       serializer: HelpDesk.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
