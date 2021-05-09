# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :the_moon_drive,
  ecto_repos: [TheMoonDrive.Repo]

# Configures the endpoint
config :the_moon_drive, TheMoonDriveWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rkZxqbu9QuHwJruX51OGOh2bcqc8K1X+Np2QT1zvqEzvbklGJfNEZVsFhFZ/7sL1",
  render_errors: [view: TheMoonDriveWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TheMoonDrive.PubSub,
  live_view: [signing_salt: "mUehbTLq"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
