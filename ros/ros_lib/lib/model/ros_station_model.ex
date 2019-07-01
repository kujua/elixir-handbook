defmodule Ros.Lib.Model.Station do
  @moduledoc false

  @type t :: %__MODULE__{
    station_id:           integer,
    assigned_dish_group:  integer,
    assigned_dish_ids:    list,
    capacity:             integer
  }

  @enforce_keys [:station_id, :assigned_dish_group]
  defstruct station_id: nil,
            assigned_dish_group: nil,
            assigned_dish_ids: [],
            capacity: 30 # maximum of displayed dishes to prepare
end