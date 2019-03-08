# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :construtora_lc_hiert,
  ecto_repos: [ConstrutoraLcHiert.Repo]

# Configures the endpoint
config :construtora_lc_hiert, ConstrutoraLcHiertWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Phs4CfFrmU3T57karO65nyLDgMsUyiADVJwuOqTVZMs/kQFv8WtcIh6dO+eeRu4P",
  render_errors: [view: ConstrutoraLcHiertWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ConstrutoraLcHiert.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Guardian - Authentication configs
config :construtora_lc_hiert, ConstrutoraLcHiert.Authentication.Guardian,
  issuer: "construtora_lc_hiert",
  secret_key: "JSLU9lItJ1mO/DdogYUyb6dqt0O1BILFKFokecXM/itqyVBT6NEdq7NzA4sY6ctX"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
