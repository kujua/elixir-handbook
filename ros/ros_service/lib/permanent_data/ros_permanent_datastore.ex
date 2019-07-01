defmodule Ros.Service.PermanentDataStore do
  @moduledoc false
  use GenServer

  @spec add(Ros.Lib.Model.Order.t) :: any
  def add(data) do
    GenServer.call(__MODULE__, {:add, data}, 3000)
  end

  def add_static_dish(data) do
    GenServer.call(__MODULE__, {:addstaticdish, data}, 3000)
  end

  def get_static_dish_list do
    GenServer.call(__MODULE__, :getstaticdishes, 3000)
  end

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(_state) do
    {:ok, []}
  end

  def handle_call({:add, ordermodel}, _from, _state) do
    Ros.Service.PermanentRepository.add(ordermodel)
    {:reply, :ok, ordermodel}
  end

  def handle_call({:addstaticdish, dishmodel}, _from, _state) do
    Ros.Service.PermanentRepository.add_static_dish(dishmodel)
    {:reply, :ok, dishmodel}
  end

  def handle_call(:getstaticdishes, _from, state) do
    list = Ros.Service.PermanentRepository.get_static_dishes
    {:reply, {:ok, list}, state}
  end
end