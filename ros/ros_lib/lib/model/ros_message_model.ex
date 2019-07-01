defmodule Ros.Lib.Model.Message do
  @moduledoc false

  alias Ros.Lib.Enum, as: Enums

  @type t() :: %__MODULE__{
    source:           String.t,
    source_order_id:  String.t,
    table_number:     integer,
    dish_id:          integer,
    timestamp:        integer,
    datetime:         struct,
    status:           String.t
  }

  @enforce_keys [:source, :source_order_id, :table_number,
                  :dish_id, :timestamp, :datetime, :status]
  defstruct source: nil,
            source_order_id: nil,
            table_number: nil,
            dish_id: [],
            timestamp: nil,
            datetime: nil,
            status: nil
end
