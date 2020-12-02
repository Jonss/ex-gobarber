# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :gobarber,
  ecto_repos: [Gobarber.Repo]

# Configures the endpoint
config :gobarber, GobarberWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5jMTdxfai2moeDxppw4F65/C8xCacTyDTFKEKGP8fyF2P0hoxhiDojEXtUZMPdsn",
  render_errors: [view: GobarberWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Gobarber.PubSub,
  live_view: [signing_salt: "8ZL0l253"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :gobarber, GobarberWeb.Auth.Guardian,
  issuer: "gobarber",
  secret_key: System.get_env("AUTH_SECRET")

config :gobarber, GobarberWeb.Auth.Pipeline,
  module: GobarberWeb.Auth.Guardian,
  error_handler: GobarberWeb.Auth.ErrorHandler
