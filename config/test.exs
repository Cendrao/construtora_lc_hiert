use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :construtora_lc_hiert, ConstrutoraLcHiertWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :construtora_lc_hiert, ConstrutoraLcHiert.Repo,
  username: "postgres",
  password: "postgres",
  database: "construtora_lc_hiert_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Email configurations with Bamboo
config :construtora_lc_hiert, ConstrutoraLcHiert.Mailer, adapter: Bamboo.TestAdapter
