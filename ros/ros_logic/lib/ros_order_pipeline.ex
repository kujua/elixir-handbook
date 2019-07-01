defmodule Ros.Logic.OrderPipeline do
  @moduledoc false
  use GenStage

  @spec process(Ros.Lib.MessageModel.t) :: Ros.Lib.MessageModel.t
  def process(messagemodel) do
    GenStage.call(__MODULE__, :init, 3000)

    {:ok} = Ros.Logic.BusinessRules.validate_message(messagemodel)
    success = GenStage.call(
      __MODULE__,
      {:process, messagemodel},
      3000
    )
    case success do
      {:ok, _} -> messagemodel
      _ -> Ros.Lib.set_status(messagemodel, :error)
    end
  end

  def start_link(state) do
    GenStage.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    {:producer, state}
  end

  def handle_call(:init, _from, state) do
    if state == [] do
      {:ok, staticagent} = DynamicSupervisor.start_child(Ros.Logic.DynamicSupervisor, {Ros.Logic.StaticData, []})
      Ros.Logic.StaticData.initialize_static_data
      {:ok, _} = DynamicSupervisor.start_child(Ros.Logic.DynamicSupervisor, {Ros.Logic.OrderState, []})
      {:reply, :ok, [], {staticagent}}
    else
      {:reply, :ok, [], state}
    end

  end

  def handle_call({:process, messagemodel}, _from, state) do
    ordermodel = Ros.Logic.BusinessRules.initialize_ordermodel(messagemodel)

#    Enum.map(ordermodel, fn o ->
      orderstate = Ros.Logic.OrderState.get_order_agent(ordermodel.order_id)
      case orderstate do
        nil -> order_agent_new_update({ordermodel, nil})
        _ -> order_agent_update(orderstate)
      end
#    end)

    case Ros.Service.process(ordermodel) do
      {:ok, ordermodellist} -> {:reply, :ok, [ordermodellist], state}
      {_, ordermodellist} -> {:reply, :error, [ordermodellist], state}
    end
  end

  def handle_demand(_demand, state) do
    {:noreply, [], state}
  end

  @spec order_agent_new_update({Ros.Lib.Model.Order, any}) :: atom
  defp order_agent_new_update {ordermodel, _} do
    {_, agentpid} = DynamicSupervisor.start_child(Ros.Logic.DynamicSupervisor, {Agent, fn -> %{} end})
    Ros.Logic.OrderState.add_order_agentpid ordermodel, agentpid
  end

  @spec order_agent_update({Ros.Lib.Model.Order, pid}) :: atom
  defp order_agent_update {ordermodel, agentpid} do
    Ros.Logic.OrderState.add_order_agentpid ordermodel, agentpid
  end


end