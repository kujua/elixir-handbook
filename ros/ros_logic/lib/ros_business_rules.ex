defmodule Ros.Logic.BusinessRules do
  @moduledoc false

  require Logger
  alias Broadway.Message
  alias Ros.Lib.Enum, as: Enums

  @alert_after :timer.seconds(900)

  @doc """
    ### Message format:

    table_number, dish_id, unix_timestamp, source_order_id
  """
  @spec validate_message(Ros.Lib.Model.Message.t) :: atom
  def validate_message(messagemodel) do
    {:ok}
  end

  @spec initialize_ordermodel(Ros.Lib.Model.Message.t) :: Ros.Lib.Model.OrderModel.t
  def initialize_ordermodel(messagemodel) do
    dm = create_dishmodel messagemodel
    {preptime, _} = Integer.parse(dm.preparation_time)
    %Ros.Lib.Model.Order{
      source: messagemodel.source,
      order_group_id: nil,
      order_id: create_order_id(),
      table_id: messagemodel.table_number,
      dish_group: Enums.dish_groups.main,
      dish: dm,
      preparation_time: preptime,
      timestamp_order: messagemodel.timestamp,
      datetime_order: messagemodel.datetime,
      datetime_projected: DateTime.add(messagemodel.datetime, @alert_after),
      station: distribute_station(dm),
      supervisor: distribute_supervisor(dm),
      runner: distribute_runner(dm),
      status: Enums.order_state.ordered,
      status_error_description: nil
    }
  end

  @spec create_timestamps(Ros.Lib.Model.Dish.t) :: {integer, integer, struct, struct}
  def create_timestamps(dishid) do

  end


  @spec create_dish(integer) :: {integer, integer, struct, struct}
  def create_dish(dishid) do

  end

  @spec create_dishmodel(Ros.Lib.Model.Message.t) :: Ros.Lib.Model.Dish.t
  def create_dishmodel messagemodel do
    data = Ros.Logic.StaticData.get_static_data(messagemodel.dish_id)
    case data do
        nil -> %Ros.Lib.Model.Dish{}
               Logger.info("create_dishmodel - nil")
        _   -> %Ros.Lib.Model.Dish{
                  dish_id: messagemodel.dish_id,
                  preparation_time: data.preparation_time,
                  name: data.name,
                  description: data.description,
                  vegetarian: data.vegetarian,
                  vegan: data.vegan,
                  availability_date_from: data.availability_date_from,
                  availability_date_to: data.availability_date_to,
                  menu_id: data.menu_id
                }
      end

  end

  def distribute_station(dish) do
     %Ros.Lib.Enum.Base{
        key: :station,
        value: "Station:1"
     }
  end

  def distribute_runner(dish) do
     %Ros.Lib.Enum.Base{
        key: :runner,
        value: "Runner:1"
     }
  end

  def distribute_supervisor(dish) do
     %Ros.Lib.Enum.Base{
        key: :supervisor,
        value: "Supervisor:0"
     }
  end

  @spec create_order_id :: String.t
  defp create_order_id do
    Ecto.UUID.generate
  end
end