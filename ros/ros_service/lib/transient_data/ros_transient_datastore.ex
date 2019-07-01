defmodule Ros.Service.TransientDataStore do
  @moduledoc false
  use GenServer
  require Logger

  @tab :order_cache
  @save_after :timer.seconds(10)

  @spec add(Ros.Lib.Model.Order.t) :: atom
  def add(ordermodel) do
    GenServer.call(__MODULE__, {:add, ordermodel}, 3000)
  end

  @spec get(atom, String.t) :: {atom, Ros.Lib.Model.Order.t}
  def get(type, orderid) do
    GenServer.call(__MODULE__, {:get, type, orderid}, 3000)
  end

  @spec getall({String.t, String.t}) :: {atom, nil}
  def getall(predicate) do
    GenServer.call(__MODULE__, {:getall, predicate}, 3000)
  end

  @spec update(Ros.Lib.Model.Order.t) :: atom
  def update(ordermodel) do
    GenServer.call(__MODULE__, {:update, ordermodel}, 3000)
  end

#  @spec updatestate(Ros.Lib.Model.Order.t) :: atom
  def updatestate({source, orderid, newstate}) do
    GenServer.call(__MODULE__, {:updatestate, {source, orderid, newstate}}, 3000)
  end

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(_state) do
    tabid = :ets.new(@tab, [:set, :named_table, :public, read_concurrency: true,
      write_concurrency: true])
    schedule_save_to_db()
    {:ok, %{tabid: tabid, unsaved_orders: []}}
  end

  def handle_call({:add, ordermodel}, _from, state) do
#    Enum.map(ordermodel, fn o ->
      true = :ets.insert(state.tabid, {ordermodel.order_id, ordermodel})
      list = List.insert_at(state.unsaved_orders, 0, ordermodel.order_id)
      state = %{state | unsaved_orders: list}
#     end)
    {:reply, :ok, state}
  end

  def handle_call({:get, for, orderid}, _from, state) do
#    Logger.info("transient datastore - get for #{inspect(for)}")
    orderlist = :ets.lookup(state.tabid, orderid)
    if orderlist == [] do
      {:reply, {:error, nil}, state}
    else
      ret = return_data(for, List.first(orderlist))
#      Logger.info("transient datastore - get return_data #{inspect(ret)}")
      {:reply, {:ok, ret}, state}
    end
  end

  def handle_call({:getall, predicate}, _from, state) do
    list = :ets.match(state.tabid, :"$1")
#    Enum.map(list, fn l ->
#        IO.inspect(l, label: "TransientDataStore getall - list")
#      end)
#    orderlist = :ets.lookup(state.tabid, orderid)
    ##    if orderlist == nil do
    ##      {:reply, {:error, nil}, state}
    ##    else
    ##      {_, order} = List.first(orderlist)
    ##      {:reply, {:ok, order}, state}
    ##    end
    {:reply, {:ok, list}, state}
  end

  def handle_call({:update, ordermodel}, _from, state) do
    true = :ets.insert(state.tabid, {ordermodel.order_id, ordermodel})
#    true = :ets.update_element(stae.tabid, ordermodel.order_id, [{pos,value}]
    {:reply, :ok, state}
  end

  def handle_call({:updatestate, {source, orderid, newstate}}, _from, state) do
    orderlist = :ets.lookup(state.tabid, orderid)
#    Logger.info("updatestate - orderlist #{inspect(orderlist)}")
    if orderlist == [] do
      {:reply, {:error, nil}, state}
    else
      {orderid, o} = List.first(orderlist)
#      Logger.info("updatestate - argument #{inspect(o)}")
      onew = %{o | status: newstate}
#      Logger.info("updatestate - updated #{inspect(onew)}")
      true = :ets.insert(state.tabid, {orderid, onew})
      {:reply, :ok, state}
    end
#    true = :ets.update_element(state.tabid, ordermodel.order_id, [{pos,value}]
    {:reply, :ok, state}
  end

  def handle_info(:savetodb, state) do
  # credo:disable-for-next-line
    Enum.map(state.unsaved_orders, fn uo ->
      {_, o} = List.first(:ets.lookup(state.tabid, uo))
      :ok = Ros.Service.PermanentDataStore.add(o)
    end)
    state = %{state | unsaved_orders: []}
    schedule_save_to_db()
    {:noreply, state}
  end
                                             
  defp schedule_save_to_db do
    Process.send_after(self(), :savetodb, @save_after)
  end

  defp return_data(for, {_, order}) do
    cond do
      String.contains?(for, "Supervisor") ->
        if for == order.supervisor.value, do: order, else: nil

      String.contains?(for, "Station") ->
        if for == order.station.value, do: order, else: nil

      String.contains?(for, "Runner") ->
        if for == order.runner.value, do: order, else: nil
    end
  end
end