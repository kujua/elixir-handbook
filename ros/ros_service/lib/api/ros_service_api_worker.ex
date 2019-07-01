defmodule Ros.Service.Api.Worker do
  @moduledoc false

  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state)
  end

  @impl true
  def init(_) do
    {:ok, nil}
  end

  @impl true
  def handle_call({:getdata, {for, orderid}}, _from, state) do
    {:reply, getstoredata({for, orderid}), state}
  end

  @impl true
  def handle_call({:newstate, {for, orderid, newstate}}, _from, state) do
    {:reply, updatestoredata({for, orderid, newstate}), state}
  end

  def getstoredata({source, orderid}) do
    Ros.Service.TransientDataStore.get(source, orderid)
  end

  def updatestoredata({source, orderid, newstate}) do
    Ros.Service.TransientDataStore.updatestate({source, orderid, newstate})
  end
end
