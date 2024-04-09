defmodule Day1.MixProject do
  use Mix.Project

  def project do
    [
      app: :day_1,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end
  defp deps do
    [
      {:data_day1 , path: "../data_advent_of_code"}
    ]
  end
end
