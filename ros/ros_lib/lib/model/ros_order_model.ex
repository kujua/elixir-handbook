defmodule Ros.Lib.Model.Order do
  @moduledoc false

  alias Ros.Lib.Enum, as: Enums

  @type t() :: %__MODULE__{
    source:                    Enums.OrderSource.t,
    order_group_id:            String.t,
    order_id:                  String.t,
    table_id:                  integer,
    dish_group:                Enums.DishGroup.t,
    dish:                      Ros.Lib.Model.Dish,
    preparation_time:          integer,
    timestamp_order:           integer,
    datetime_order:            struct,
    datetime_projected:        struct,
    station:                   Ros.Lib.Enum.Base.t,
    supervisor:                Ros.Lib.Enum.Base.t,
    runner:                    Ros.Lib.Enum.Base.t,
    status:                    Enums.OrderState.t,
    status_error_description:  String.t
  }

  @enforce_keys [:order_group_id, :order_id, :table_id, :dish, :preparation_time,
    :timestamp_order, :station]
  @derive Jason.Encoder
  defstruct source: nil,
            order_group_id: nil,
            order_id: nil,
            table_id: nil,
            dish_group: nil,
            dish: %Ros.Lib.Model.Dish{dish_id: nil, preparation_time: nil},
            preparation_time: nil,
            timestamp_order: nil,
            datetime_order: nil,
            datetime_projected: nil,
            station: nil,
            supervisor: nil,
            runner: nil,
            status: nil,
            status_error_description: nil

end