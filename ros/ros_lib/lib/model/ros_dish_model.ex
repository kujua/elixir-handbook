defmodule Ros.Lib.Model.Dish do
  @moduledoc false

  alias Ros.Lib.Enum, as: Enums

  @type dish_model :: %__MODULE__{
    dish_id:                  integer,
    dish_group:               Enums.DishGroup.t,
    preparation_time:         String.t,
    name:                     String.t,
    description:              String.t,
    vegetarian:               boolean,
    vegan:                    boolean,
    availability_date_from:   struct,
    availability_date_to:     struct,
    menu_id:                  integer
  }

#  @enforce_keys [:dish_id, :preparation_time]
  @derive Jason.Encoder
  defstruct dish_id: nil,
            dish_group: nil,
            preparation_time: nil,
            name: nil,
            description: nil,
            vegetarian: nil,
            vegan: nil,
            availability_date_from: nil,
            availability_date_to: nil,
            menu_id: nil
end
