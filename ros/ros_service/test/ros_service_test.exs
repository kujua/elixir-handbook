defmodule Ros.Service.Test do
  use ExUnit.Case
  alias Ros.Lib.Enum, as: Enums
  
  setup do
    uid = Ecto.UUID.generate
    etstab = :order_cache_test
    ordermodel = [%Ros.Lib.Model.Order{
      order_group_id: nil,
      order_id: uid,
      table_id: 22,
      dish_group: Enums.dish_groups.main,
      dish: 99,
      preparation_time: nil,
      timestamp_order: "1559068914",
      datetime_order: nil,
      datetime_projected: nil,
      station: Enums.stations.station1,
      supervisor: Enums.stations.supervisor,
      runner: Enums.stations.runner1,
      status: Enums.order_state.ordered,
      status_error_description: nil
    }]
    ordermodelupdated = [%Ros.Lib.Model.Order{
      order_group_id: nil,
      order_id: uid,
      table_id: 24,
      dish_group: Enums.dish_groups.main,
      dish: 15,
      preparation_time: nil,
      timestamp_order: "1559068914",
      datetime_order: nil,
      datetime_projected: nil,
      station: Enums.stations.station1,
      supervisor: Enums.stations.supervisor,
      runner: Enums.stations.runner1,
      status: Enums.order_state.ordered,
      status_error_description: nil
    }]
    dishmodel = %Ros.Lib.Model.Dish{
      dish_id: 1001,
      dish_group: Enums.dish_groups.starter,
      preparation_time: "4",
      name: "Mini quiche Lorraine",
      description: "succulent ham and herb filling",
      vegetarian: true,
      vegan: false,
      availability_date_from: DateTime.utc_now() |> DateTime.truncate(:second),
      availability_date_to: DateTime.utc_now() |> DateTime.truncate(:second),
      menu_id: 9999
    }
    
    {:ok,
      etstab: etstab,
      ordermodel: ordermodel,
      ordermodelupdated: ordermodelupdated,
      dishmodel: dishmodel
    }
  end

  @tag :dummy
  test "dummy" do
    assert(true)
  end

  @tag :etsraw
  test "add_data_to_ets_raw", context do
    id = :ets.new(context[:etstab], [:set, :named_table, :public, read_concurrency: true,
      write_concurrency: true])

    assert(:ets.insert(id, {List.first(context[:ordermodel]).order_id, List.first(context[:ordermodel])}))
    assert(:ets.member(id, List.first(context[:ordermodel]).order_id))

    :ets.delete id
  end

  @tag :etsraw
  test "retrieve_data_from_ets_raw", context do
    id = :ets.new(context[:etstab], [:set, :named_table, :public, read_concurrency: true,
      write_concurrency: true])

    assert(:ets.insert(id, {List.first(context[:ordermodel]).order_id, List.first(context[:ordermodel])}))
    objectlist = :ets.lookup(context[:etstab], List.first(context[:ordermodel]).order_id)

    assert(length(objectlist) == 1)

    {_, object} = List.first(objectlist)
    assert(object == List.first(context[:ordermodel]))
    
    :ets.delete id
  end

  @tag :ets
  test "add_data_to_ets", context do
    success = Ros.Service.TransientDataStore.add(List.first(context[:ordermodel]))
    assert(success == :ok)
  end

  @tag :ets
  test "retrieve_data_from_ets", context do
    success = Ros.Service.TransientDataStore.add(List.first(context[:ordermodel]))
    assert(success == :ok)

    {:ok, order} = Ros.Service.TransientDataStore.get(List.first(context[:ordermodel]).order_id)
    assert(order == List.first(context[:ordermodel]))
  end

  @tag :ets
  test "update_data_in_ets", context do
    success = Ros.Service.TransientDataStore.add(List.first(context[:ordermodel]))
    assert(success == :ok)

    {:ok, order} = Ros.Service.TransientDataStore.get(List.first(context[:ordermodel]).order_id)
    assert(order == List.first(context[:ordermodel]))

    success = Ros.Service.TransientDataStore.update(List.first(context[:ordermodelupdated]))
    assert(success == :ok)

    {:ok, order} = Ros.Service.TransientDataStore.get(List.first(context[:ordermodelupdated]).order_id)
    assert(order == List.first(context[:ordermodelupdated]))
  end

  @tag :scheduled
  test "scheduled write to db", context do
    success = Ros.Service.TransientDataStore.add(List.first(context[:ordermodel]))
    assert(success == :ok)

    Process.sleep(15_000)
  end

  @tag :db
  test "write to db", context do
    success = Ros.Service.PermanentDataStore.add(List.first(context[:ordermodel]))
    assert(success == :ok)
  end

  @tag :socket
  test "join topic" do
    success = Ros.Service.send_newdata_message()
    assert(success == :ok)
    Process.sleep(1000)
  end

  @tag :staticdata
  test "create static data", context do
    IO.inspect(context[:dishmodel], label: "test - create static data")
    success = Ros.Service.PermanentDataStore.add_static_dish(context[:dishmodel])
    assert(success == :ok)
  end
end
