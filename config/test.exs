use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :spreedly_airlines_elixir, SpreedlyAirlinesElixir.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
# Update to print other messages
config :logger, level: :debug

# Spreedly settings
config :spreedly_airlines_elixir, SpreedlyAirlinesElixir.Endpoint,
  base_url: "https://core.spreedly.com",
  env_key: "VoypMN17B1VZQcWsxkoKIW2hvbU",
  access_secret: "9ifOr8xjla71SAklGvxyf4lJgfMWUKM9MGCsODKxdz1tTkQFEiznAlQ9xpfCEO4a",
  gateway_token: "EinedeTu7HzwQK38QiWYqxwJzv7"