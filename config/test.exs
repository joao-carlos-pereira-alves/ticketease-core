import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :help_desk, HelpDesk.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "help_desk_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :help_desk, HelpDeskWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "gMADgGiq0azLDJOa/irtwmaUqh17XFFaShYO37wJo8Oat971bG88Utp9WcSu6b8g",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :help_desk, HelpDesk.Mailer,
  adapter: Bamboo.LocalAdapter,
  server: "smtp.domain",
  port: 1025,
  username: System.get_env("SMTP_USERNAME"),
  password: System.get_env("SMTP_PASSWORD"),
  tls: :if_available, # can be `:always` or `:never`
  ssl: false, # can be `true`
  retries: 1
