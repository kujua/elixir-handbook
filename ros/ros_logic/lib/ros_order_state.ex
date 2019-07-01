defmodule Ros.Logic.OrderState do
  @moduledoc false

  use Agent

#  @spec get_order_agent(id) :: Ros.Lib.Model.Order.t
  def get_order_agent id do
    Agent.get(__MODULE__, fn state ->
        Enum.find(state, nil, fn {o, _} ->
          o.order_id == id end
        )
      end
    )
  end

  def add_order_agentpid(ordermodel, agentpid)  do
    Agent.update(__MODULE__, fn state -> List.insert_at(state, 0, {ordermodel, agentpid}) end)
  end

  def get_all_orderstate do
    Agent.get(__MODULE__, fn state -> state end)
  end

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

end