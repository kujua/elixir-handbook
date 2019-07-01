defmodule Ros.ServiceApiWeb.DataChannel do
  use Phoenix.Channel
  require Logger

  def join("rosdata:read", _message, socket) do
    {:ok, socket}
  end
#  def join("data:" <> _private_room_id, _params, _socket) do
#    {:error, %{reason: "unauthorized"}}
#  end


  def handle_in("get_data_supervisor", %{"body" => body, "orderid" => orderid}, socket) do
    nodename = Application.get_env(:ros_service_api, Ros.ServiceApiWeb.Endpoint)[:logic_node]
    {:ok, order} = Task.Supervisor.async({Ros.Service.TaskSupervisor, String.to_atom(nodename)}, Ros.Service.Api, :getdata, [{body, orderid}])
                   |> Task.await()
    push(socket, "receive_data", %{body: order_to_json(order)})
#    case order do
#      [] -> msg = "No order found"
#      _ ->
#        obj = Enum.map(order, fn l ->
#          {_, o} = List.first(l)
#          o
#        end)
#        push(socket, "receive_data", %{body: order_to_json(obj)})
#    end
    {:noreply, socket}
  end

  def handle_in("get_data_station", %{"body" => body, "orderid" => orderid}, socket) do
    nodename = Application.get_env(:ros_service_api, Ros.ServiceApiWeb.Endpoint)[:logic_node]
    {:ok, order} = Task.Supervisor.async({Ros.Service.TaskSupervisor, String.to_atom(nodename)}, Ros.Service.Api, :getdata, [{body, orderid}])
                       |> Task.await()
    push(socket, "receive_data", %{body: order_to_json(order)})
    {:noreply, socket}
  end


  def handle_in("get_data_runner", %{"body" => body, "orderid" => orderid}, socket) do
    nodename = Application.get_env(:ros_service_api, Ros.ServiceApiWeb.Endpoint)[:logic_node]
    {:ok, order} = Task.Supervisor.async({Ros.Service.TaskSupervisor, String.to_atom(nodename)}, Ros.Service.Api, :getdata, [{body, orderid}])
                   |> Task.await()
    push(socket, "receive_data", %{body: order_to_json(order)})
    {:noreply, socket}
  end

  def handle_in("change_state_supervisor", %{"body" => body, "orderid" => orderid, "newstate" => newstate}, socket) do
    Logger.info("change_state_supervisor - orderid #{inspect(orderid)}")
    Logger.info("change_state_supervisor - newstate #{inspect(newstate)}")
    nodename = Application.get_env(:ros_service_api, Ros.ServiceApiWeb.Endpoint)[:logic_node]
    ret = Task.Supervisor.async({Ros.Service.TaskSupervisor, String.to_atom(nodename)}, Ros.Service.Api, :newstate, [{body, orderid, newstate}])
                   |> Task.await()
    broadcast!(socket, "updated_data", %{body: orderid})
    {:noreply, socket}
  end

  def handle_in("new_data", %{"body" => body}, socket) do
#    {:ok, data} = Ros.Service.get_data(:supervisor)
    broadcast!(socket, "updated_data", %{body: body})
    {:noreply, socket}
  end

  defp order_to_json(order) do
    Jason.encode!(order)
  end

end