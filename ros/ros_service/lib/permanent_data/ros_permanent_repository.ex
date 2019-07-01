defmodule Ros.Service.PermanentRepository do
  @moduledoc false


  use Ecto.Repo,
      otp_app: :ros_service,
      adapter: Ecto.Adapters.Postgres
  import Ecto.Query
  
#  @spec add(Ros.Lib.Model.Order.t) :: any
  def add(ordermodel) do
    orderdata = %Ros.Service.PermanentData.Order{
      source: ordermodel.source,
      order_group_id: ordermodel.order_group_id,
      order_id: ordermodel.order_id,
      table_id: ordermodel.table_id,
      dish_group: ordermodel.dish_group,
      dish: cond  do
              ordermodel.dish == [] -> nil
              true -> Map.from_struct(ordermodel.dish)
            end,
      preparation_time: ordermodel.preparation_time,
      timestamp_order: ordermodel.timestamp_order,
      datetime_order: ordermodel.datetime_order,
      datetime_projected: ordermodel.datetime_projected,
      station: Map.from_struct(ordermodel.station),
      supervisor: Map.from_struct(ordermodel.supervisor),
      runner: Map.from_struct(ordermodel.runner),
      status: ordermodel.status,
      status_error_description: ordermodel.status_error_description
    }
    insert!(orderdata)
  end

  def add_static_dish(dishmodel) do
      dishdata = %Ros.Service.PermanentData.Static.Dishes{
        dish_id: dishmodel.dish_id,
        dish_group: dishmodel.dish_group,
        preparation_time: dishmodel.preparation_time,
        name: dishmodel.name,
        description: dishmodel.description,
        vegetarian: dishmodel.vegetarian,
        vegan: dishmodel.vegan,
        availability_date_from: dishmodel.availability_date_from,
        availability_date_to: dishmodel.availability_date_to,
        menu_id: dishmodel.menu_id
      }
      insert!(dishdata)
  end

  def get_static_dishes do
    query = from d in Ros.Service.PermanentData.Static.Dishes,
            select: d
    all(query)
  end
end