# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :bleacher_report_api, BleacherReportApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2lP4hXU6COcoTf66DMJnDzXfahzUgnemX0zu7PzFmc6JDbBW+tFCCBDGAKx36bIR",
  render_errors: [view: BleacherReportApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: BleacherReportApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
