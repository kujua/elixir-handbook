defmodule Ros.Logic.Transformer do
  @moduledoc false

#  import Ecto
  alias Broadway.Message
  alias Ros.Lib.Enum, as: Enums

  @spec transform_message_to_broadwaymessage(String.t, list) :: Broadway.Message.t
  def transform_message_to_broadwaymessage(message, opts) do
    model = create_messagemodel(message, List.first(opts))
    %Message{
      data: model,
      acknowledger: {Ros.Logic, :ack_ros_logic, :ack_data}
    }
  end

  @spec create_messagemodel(String.t, atom) :: Ros.Lib.Model.Message.t
  def create_messagemodel(message, source) do
    list = String.split(message, ",")
    {:ok, date} = DateTime.from_unix(String.to_integer(Enum.at(list, 2)))
    %Ros.Lib.Model.Message{
      source: Enums.order_source_from_atom(source),
      source_order_id: Enum.at(list, 3),
      table_number: Enum.at(list, 0),
      dish_id: Enum.at(list, 1),
      timestamp: Enum.at(list, 2),
      datetime: date,
      status: nil
    }
  end

#  @spec create_ordermodel_from_messagemodel(Ros.Lib.Model.Message.t) :: [Ros.Lib.Model.Order.t]
#  def create_ordermodel_from_messagemodel(messagemodel) do
##    IO.inspect(messagemodel, label: "create_ordermodel_from_messagemodel")
#    dmlist = create_dishmodel_list messagemodel
#    Enum.map(dmlist, fn d ->
#        %Ros.Lib.Model.Order{
#          order_group_id: nil,
#          order_id: create_order_id(),
#          table_id: messagemodel.table_id,
#          dish_group: Enums.dish_groups.main,
#          dish: d,
#          preparation_time: nil,
#          timestamp_order: messagemodel.timestamp,
#          datetime_order: messagemodel.datetime,
#          datetime_projected: DateTime.add(messagemodel.datetime, 900),
#          station: Enums.stations.station1,
#          supervisor: Enums.stations.supervisor,
#          runner: Enums.stations.runner1,
#          status: messagemodel.status,
#          status_error_description: nil
#        }
#      end
#    )
#
#  end



#  defp validate_model(model) do
#    IO.inspect(model, label: "validate_model")
#    model
#  end





end
