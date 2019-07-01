defmodule Ros.Service.PermanentData.Static.Dishes do
  @moduledoc false

  use Ecto.Schema

  schema "dishes" do
    field :dish_id,                  :integer
    field :dish_group,               :map
    field :preparation_time,         :string
    field :name,                     :string
    field :description,              :string
    field :vegetarian,               :boolean
    field :vegan,                    :boolean
    field :availability_date_from,   :utc_datetime
    field :availability_date_to,     :utc_datetime
    field :menu_id,                  :integer
  end

end