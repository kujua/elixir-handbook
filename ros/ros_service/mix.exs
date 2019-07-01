defmodule RosService.MixProject do
  use Mix.Project

  def project do
    [
      app: :ros_service,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [
        plt_add_deps: :ros_lib,
        paths: ["_build/dev/lib/ros_lib/ebin"]
      ]

    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Ros.Service.Application, []}
    ]
  end

  defp deps do
    [
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:dialyxir, "~> 1.0.0-rc.6", only: [:dev], runtime: false},
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:websocket_client, "~> 1.2"},
      {:poison, "~> 2.0"},
      {:phoenix_gen_socket_client, "~> 2.1.1"},
      {:ros_lib, path: "../ros_lib"}
    ]
  end
end
