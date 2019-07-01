defmodule Ros.Service do
  @moduledoc false

  use GenServer
  alias Phoenix.Channels.GenSocketClient

  def send_newdata_message(orderid) do
    GenSocketClient.call(Ros.Service.DataSocketClient, {:new_data, orderid}, 3000)
  end

#  def get_data(for) do
#    GenServer.call(__MODULE__, {:getdata, for}, 3000)
#  end

  @spec process(list(Ros.Lib.Model.Order.t)) :: {atom, list(Ros.Lib.Model.Order.t)}
  def process(ordermodellist) do
    case GenServer.call(__MODULE__, {:process, ordermodellist}, 3000) do
      :ok -> {:ok, ordermodellist}
      _ -> {:error, Ros.Lib.set_status(ordermodellist, :error)}
    end
  end

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(_opts) do
    {:ok, []}
  end

  @impl true
  def handle_call({:process, ordermodel}, _from, _state) do
#    _list = Enum.map(ordermodellist, fn o ->
        :ok = Ros.Service.TransientDataStore.add(ordermodel)
        send_newdata_message ordermodel.order_id
#      end)
    {:reply, :ok, ordermodel}
  end

#  @impl true
#  def handle_call({:getdata, for}, _from, _state) do
#    {:ok, list} = Ros.Service.TransientDataStore.getall()
#    {:reply, :ok, list}
#  end

end
