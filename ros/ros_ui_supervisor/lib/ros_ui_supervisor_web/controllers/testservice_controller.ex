defmodule Ros.SupervisorWeb.TestserviceController do
  use Ros.SupervisorWeb, :controller

  def getservice(conn, _params) do
    nodename = Application.get_env(:ros_ui_supervisor, Ros.SupervisorWeb.Endpoint)[:logic_node]
    {:ok, order} = Task.Supervisor.async({Ros.Service.TaskSupervisor, String.to_atom(nodename)}, Ros.Service.Api, :hello, [])
              |> Task.await()
    IO.inspect(order, label: "Ros.SupervisorWeb - getservice")

    case order do
      [] -> text(conn, "No order found")
      _ ->
        s = Enum.map(order, fn l ->
          s = ""
          {_, o} = List.first(l)
          s <> o.order_id
        end)
        IO.inspect(s, label: "Ros.SupervisorWeb - getservice enum")
        text(conn, "Got list: " <> List.to_string(s))
    end


  end


end