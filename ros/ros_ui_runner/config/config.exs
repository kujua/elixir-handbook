# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ros_ui_runner,
  namespace: Ros.Runner

# Configures the endpoint
config :ros_ui_runner, Ros.RunnerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "cP2AN04NvdCoLs7j+o48qz/I2CTmwN6+fnWcxuRaAEVqqY+Y7GGbdMUOg9rGaEB0",
  render_errors: [view: Ros.RunnerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ros.Runner.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
