defmodule Ros.Service.PermanentData.Order do
  @moduledoc false
  
  use Ecto.Schema

  schema "orders" do
    field :source,                    :map
    field :order_group_id,            :string
    field :order_id,                  :string
    field :table_id,                  :string
    field :dish_group,                :map
    embeds_one :dish, Ros.Service.PermanentData.Dish
    field :preparation_time,          :integer
    field :timestamp_order,           :string
    field :datetime_order,            :utc_datetime
    field :datetime_projected,        :utc_datetime
    field :station,                   :map
    field :supervisor,                :map
    field :runner,                    :map
    field :status,                    :map
    field :status_error_description,  :string
  end

end