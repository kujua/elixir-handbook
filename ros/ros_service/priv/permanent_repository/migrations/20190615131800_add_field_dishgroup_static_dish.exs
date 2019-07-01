defmodule Ros.Service.PermanentRepository.Migrations.CreateStaticDishes do
  use Ecto.Migration

  def change do
     alter table(:dishes) do
      add :dish_group, :map
    end
  end
end
