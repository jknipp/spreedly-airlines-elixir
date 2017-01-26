# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :spreedly_airlines_elixir, SpreedlyAirlinesElixir.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bdHu0gRwMbvEvuXT/Nv5GaeRpfBp/LTTaUMszUWCR0EQe/Z/p8G1lWEoCK04JR3h",
  render_errors: [view: SpreedlyAirlinesElixir.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SpreedlyAirlinesElixir.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Spreedly settings
config :spreedly_airlines_elixir, Spreedly.Api,
  base_url: "https://core.spreedly.com",
  env_key: "D7zlEmeIJBaHxjQU9DKK5Bn7kON",
  access_secret: "9ifOr8xjla71SAklGvxyf4lJgfMWUKM9MGCsODKxdz1tTkQFEiznAlQ9xpfCEO4a",
  gateway_token: "SGsZDEjO8p6g2lHYDesaPzGsMPD",
  receiver_token: "YgLkLoHSQUTMALPc8MO3mKNbqSl"
  
config :spreedly_airlines_elixir, :spreedly, Spreedly

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"


