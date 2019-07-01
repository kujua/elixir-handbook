defmodule RosLogic.MixProject do
  use Mix.Project

  def project do
    [
      app: :ros_logic,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [
        plt_add_deps: :ros_lib,
        paths: ["_build/dev/lib/ros_lib/ebin",
          "_build/dev/lib/ros_service/ebin"]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Ros.Logic.Application, []}
    ]
  end

  defp deps do
    [
      {:broadway_rabbitmq, "~> 0.1.0"},
      {:ecto_sql, "~> 3.0"},
      {:jason, "~> 1.1"},
      {:dialyxir, "~> 1.0.0-rc.6", only: [:dev], runtime: false},
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:ros_service, path: "../ros_service"},
      {:ros_lib, path: "../ros_lib"}
    ]
  end
end
