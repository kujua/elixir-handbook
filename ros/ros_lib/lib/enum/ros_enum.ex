defmodule Ros.Lib.Enum do
  @moduledoc false

  @spec order_state :: Ros.Lib.Enum.OrderState.t
  def order_state do
    %Ros.Lib.Enum.OrderState{}
  end

  @spec order_state :: Ros.Lib.Enum.OrderState.t
  def order_state_from_string(state) do
    case state do
      "ordered" -> %Ros.Lib.Enum.OrderState{}.ordered
      "prepare" -> %Ros.Lib.Enum.OrderState{}.prepare
      "serve"   -> %Ros.Lib.Enum.OrderState{}.serve
    end

  end

  @spec dish_groups :: Ros.Lib.Enum.DishGroup.t
  def dish_groups do
    %Ros.Lib.Enum.DishGroup{}
  end

  @spec stations :: Ros.Lib.Enum.Station.t
  def stations do
    %Ros.Lib.Enum.Station{}
  end

  @spec dish_groups_from_number(integer) :: Ros.Lib.Enum.DishGroup.t
  def dish_groups_from_number(_n) do
    %Ros.Lib.Enum.DishGroup{}
  end

  @spec order_source :: Ros.Lib.Enum.OrderSource.t
  def order_source() do
    %Ros.Lib.Enum.OrderSource{}
  end

  @spec order_source_from_atom(atom) :: Ros.Lib.Enum.OrderSource.t
  def order_source_from_atom(source) do
    case source do
      :service -> %Ros.Lib.Enum.OrderSource{}.service
#      :telephone -> Ros.Lib.Enum.OrderSource.telephone
#      :online_takeaway -> Ros.Lib.Enum.OrderSource.online_takeaway
#      :telephone_takeaway -> Ros.Lib.Enum.OrderSource.telephone_takeaway
    end
  end
end