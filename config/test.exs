import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :reserva_online, ReservaOnline.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "reserva_online_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :reserva_online, ReservaOnlineWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "gMADgGiq0azLDJOa/irtwmaUqh17XFFaShYO37wJo8Oat971bG88Utp9WcSu6b8g",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
