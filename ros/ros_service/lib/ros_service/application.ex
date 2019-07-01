defmodule Ros.Service.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Ros.Service,
      Ros.Service.TransientDataStore,
      Ros.Service.PermanentDataStore,
      Ros.Service.PermanentRepository,
      {DynamicSupervisor, strategy: :one_for_one, name: Ros.Service.Api.Supervisor},
      {Task.Supervisor, name: Ros.Service.TaskSupervisor},
      %{
        id: Ros.Service.DataSocketClient,
        start: {Ros.Service.DataSocketClient, :start_link, []}
      }
    ]

    opts = [strategy: :one_for_one, name: RosService.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
