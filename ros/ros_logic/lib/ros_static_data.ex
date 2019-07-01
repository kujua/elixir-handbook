defmodule Ros.Logic.StaticData do
  @moduledoc false

  require Logger
  use Agent

  def initialize_static_data do
    {:ok, list} = Ros.Service.PermanentDataStore.get_static_dish_list
    fields = Ros.Service.PermanentData.Static.Dishes.__schema__(:fields)
    Enum.map(list, fn d ->
        sm = struct(%Ros.Lib.Model.Dish{}, Map.take(d, fields))
        Agent.update(__MODULE__,
          fn state -> List.insert_at(state, 0, sm) end)
      end
    )
  end

  def get_static_data(dishid) do
    Agent.get(__MODULE__, fn state ->
        Logger.info("get_static_data - state #{inspect(state)}")
        Enum.find(state, nil, fn d ->
             {id, _} = Integer.parse(dishid)
            d.dish_id == id
          end
        )
      end
    )
  end

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end
end