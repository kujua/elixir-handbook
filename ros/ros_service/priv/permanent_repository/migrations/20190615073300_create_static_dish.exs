defmodule Ros.Service.PermanentRepository.Migrations.CreateStaticDishes do
  use Ecto.Migration

  def change do
     create table(:dishes) do
      add :dish_id,                  :integer
      add :preparation_time,         :string
      add :name,                     :string
      add :description,              :string
      add :vegetarian,               :boolean
      add :vegan,                    :boolean
      add :availability_date_from,   :utc_datetime
      add :availability_date_to,     :utc_datetime
      add :menu_id,                  :integer
    end
  end
end
