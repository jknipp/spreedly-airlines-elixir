use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :spreedly_airlines_elixir, SpreedlyAirlinesElixir.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
# Update to print other messages
config :logger, level: :debug

config :spreedly_airlines_elixir, :spreedly, Spreedly.Mock