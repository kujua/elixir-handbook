defmodule Ros.Logic.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Ros.Logic,
      Ros.Logic.OrderPipeline,
      {DynamicSupervisor, strategy: :one_for_one, name: Ros.Logic.DynamicSupervisor}
    ]

    opts = [strategy: :one_for_one, name: Ros.Logic.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
