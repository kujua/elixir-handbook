defmodule Ros.Service.PermanentRepository.Migrations.CreateOrder do
  use Ecto.Migration

  def change do
     create table(:orders) do
      add :source,                    :map
      add :order_group_id,            :string
      add :order_id,                  :string
      add :table_id,                  :string
      add :dish_group,                :map
      add :dish,                      :map
      add :preparation_time,          :integer
      add :timestamp_order,           :string
      add :datetime_order,            :utc_datetime
      add :datetime_projected,        :utc_datetime
      add :station,                   :map
      add :supervisor,                :map
      add :runner,                    :map
      add :status,                    :map
      add :status_error_description,  :string
    end
  end
end
