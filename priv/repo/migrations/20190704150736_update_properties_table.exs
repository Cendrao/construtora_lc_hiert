defmodule ConstrutoraLcHiert.Repo.Migrations.UpdatePropertiesTable do
  use Ecto.Migration

  def change do
    alter table(:properties) do
      modify :qty_rooms, :integer, null: true
      modify :qty_bathrooms, :integer, null: true
      modify :qty_kitchens, :integer, null: true
      modify :qty_garages, :integer, null: true
    end
  end
end
