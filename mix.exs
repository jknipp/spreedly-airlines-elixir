defmodule SpreedlyAirlinesElixir.Mixfile do
  use Mix.Project

  def project do
    [app: :spreedly_airlines_elixir,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {SpreedlyAirlinesElixir, []},
     applications: [:phoenix, :phoenix_pubsub, :phoenix_html, :cowboy, :logger, :gettext, :number, :httpoison, :poison]]
  end

  # Specifies which paths to compile per environment.
  # Update this if you add extra paths in testing that need to be available in the app (i.e. Mocking)
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.2.1"},
     {:phoenix_pubsub, "~> 1.0"},
     {:phoenix_html, "~> 2.6"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:gettext, "~> 0.11"},
     {:cowboy, "~> 1.0"},
     {:number, "~> 0.4.2"},
     {:httpoison, "~> 0.10.0"},
     {:poison, "~> 2.0"},
     {:mock, "~> 0.2.0", only: :test}]
  end
end
