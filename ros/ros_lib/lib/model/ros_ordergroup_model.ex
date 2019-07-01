defmodule Ros.Lib.Model.OrderGroup do
  @moduledoc false

  @type t :: %__MODULE__{
    order_group_id: integer,
    orders:         list
  }

  @enforce_keys [:order_group_id, :orders]
  defstruct order_group_id: nil,
            orders: []
end
