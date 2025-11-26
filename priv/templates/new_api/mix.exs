defmodule <%= @app_module %>.MixProject do
  use Mix.Project

  def project do
    [
      app: :<%= @app_name %>,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {<%= @app_module %>.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:plug, "~> 1.15"},
      {:plug_cowboy, "~> 2.6"},
      {:jason, "~> 1.4"},
      {:ecto_sql, "~> 3.10"},
      {:cors_plug, "~> 3.0"},
      {:phoenix, "~> 1.7.0"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_pubsub, "~> 2.1"},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false}
    ]
  end
end
