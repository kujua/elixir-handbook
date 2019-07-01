defmodule Ros.Service.Api do
  @moduledoc false

  require Logger

  def getdata(predicate) do
    {for, _} = predicate
    spec  = Supervisor.child_spec({Ros.Service.Api.Worker, fn -> :ok end},
              id: {Ros.Service.Api.Worker, for})
    {:ok, pid} = DynamicSupervisor.start_child(Ros.Service.Api.Supervisor, spec)
    ret = GenServer.call(pid, {:getdata, predicate})
    DynamicSupervisor.terminate_child(Ros.Service.Api.Supervisor, pid)
    ret
  end

  def newstate(predicate) do
    {for, orderid, newstate} = predicate
    spec  = Supervisor.child_spec({Ros.Service.Api.Worker, fn -> :ok end},
              id: {Ros.Service.Api.Worker, for})
    {:ok, pid} = DynamicSupervisor.start_child(Ros.Service.Api.Supervisor, spec)
    newstateenum = Ros.Lib.Enum.order_state_from_string(newstate)
    Logger.info("service.api newstate - newstateenum #{inspect(newstateenum)}")
    ret = GenServer.call(pid, {:newstate, {for, orderid, newstateenum}})
    Logger.info("service.api newstate - ret #{inspect(ret)}")
    DynamicSupervisor.terminate_child(Ros.Service.Api.Supervisor, pid)
    ret
  end

end
