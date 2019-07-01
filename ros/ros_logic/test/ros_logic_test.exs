defmodule Ros.Logic.Test do
  use ExUnit.Case

# credo:disable-for-this-file
  setup do
    dish_id_list = [
      %Ros.Lib.Model.Dish{
        availability_time: nil,
        dish_id: 22,
        dish_name: nil,
        menu_id: "",
        preparation_time: nil
      },
      %Ros.Lib.Model.Dish{
        availability_time: nil,
        dish_id: 24,
        dish_name: nil,
        menu_id: "",
        preparation_time: nil
      }
    ]
    message = "service,3,2,,[22;24],1559068914"
    {:ok, datetime} = DateTime.from_unix(1559068914)
    datetimeplus = DateTime.add(datetime, 900)
    ordermodel = [%Ros.Lib.Model.Order{
                    datetime_order: datetime,
                    datetime_projected: datetimeplus,
                    dish: %Ros.Lib.Model.Dish{
                      availability_time: nil,
                      dish_id: 22,
                      dish_name: nil,
                      menu_id: "",
                      preparation_time: nil
                    },
                    dish_group: {:main, "Main"},
                    order_group_id: nil,
                    order_id: "07dbc062-1317-46be-9081-065729268867",
                    preparation_time: nil,
                    runner: {:runner1, "Runner"},
                    station: {:station1, "Station 1"},
                    status: {:ordered, "Ordered"},
                    status_error_description: nil,
                    supervisor: {:supervisor, "Supervisor"},
                    table_id: "3",
                    timestamp_order: "1559068914"
                  },
                  %Ros.Lib.Model.Order{
                    datetime_order: datetime,
                    datetime_projected: datetimeplus,
                    dish: %Ros.Lib.Model.Dish{
                      availability_time: nil,
                      dish_id: 24,
                      dish_name: nil,
                      menu_id: "",
                      preparation_time: nil
                    },
                    dish_group: {:main, "Main"},
                    order_group_id: nil,
                    order_id: "07dbc062-1317-46be-9081-065729268867",
                    preparation_time: nil,
                    runner: {:runner1, "Runner"},
                    station: {:station1, "Station 1"},
                    status: {:ordered, "Ordered"},
                    status_error_description: nil,
                    supervisor: {:supervisor, "Supervisor"},
                    table_id: "3",
                    timestamp_order: "1559068914"
                  }
                ]
    {:ok, message: message, dish_id_list: dish_id_list, ordermodel: ordermodel}
  end

  @tag :dummy
  test "dummy" do
    assert(true)
  end

  @tag :broadway
  test "broadway pipeline integration test" do
    # table_number, dish_id, unix_timestamp, source_order_id
    # 3,1001,1559068914, 999
    message =
      "3,"
      <> "25,"
      <> "1559068914,"
      <> "999"

    _ref = Broadway.test_messages(RosBroadway, [message])
    Process.sleep(1000)
#    IO.inspect(ref, label: "Reference 1")
#    ref = Broadway.test_messages(RosBroadway, [message])
#    Process.sleep(1000)
#    IO.inspect(ref, label: "Reference 2")
  end

  @tag :transformer
  test "create dishlist", context do
    model = Ros.Logic.Transformer.create_messagemodel(context[:message])
    list = Ros.Logic.Transformer.create_dishmodel_list(model)
#    IO.inspect(list, label: "dishlist - list")
    assert(list == context[:dish_id_list])
  end

  @tag :transformer
  test "create ordermodel", context do
    model = Ros.Logic.Transformer.create_messagemodel(context[:message])
    list = Ros.Logic.Transformer.create_ordermodel_from_messagemodel(model)
    list_with_known_id = Enum.map(list, fn om ->
      %{om | order_id: "07dbc062-1317-46be-9081-065729268867"}
     end)
#    IO.inspect(list, label: "dishlist - list")
    assert(list_with_known_id == context[:ordermodel])
  end


end
