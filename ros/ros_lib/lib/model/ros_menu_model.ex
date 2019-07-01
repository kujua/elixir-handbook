defmodule Ros.Lib.Model.Menu do
  @moduledoc false

  @type t :: %__MODULE__{
    menu_id:  integer,
    dishes:   list
  }

  @enforce_keys [:menu_id, :dishes]
  defstruct menu_id: nil,
            dishes: []
end