# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ros_ui_admin,
  namespace: Ros.Admin

# Configures the endpoint
config :ros_ui_admin, Ros.AdminWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pEEcYWpz7D9eS9ija3S1k39qQLeONeGb7OxfEcilWQtMelFSBzEa3Zf3kHim3D2h",
  render_errors: [view: Ros.AdminWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ros.Admin.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
