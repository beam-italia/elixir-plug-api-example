defmodule Api.Mixfile do
  use Mix.Project

  def project do
    [app: :api,
     version: "0.0.1",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger, :postgrex, :plug, :cowboy],
     mod: {Api, []}
    ]
  end

  defp deps do
    [
      {:plug, "~> 1.0"},
      {:cowboy, "~> 1.0.0"},
      {:corsica, "~> 0.4"},
      {:poison, "~> 1.5"},
      {:postgrex, "~> 0.9.1"},
      {:plug_basic_auth, "~> 1.0"},
      {:mock, "~> 0.1.1"}
    ]
  end
end
