defmodule ConstrutoraLcHiert.Repo.Migrations.CreateProperties do
  use Ecto.Migration

  def change do
    create table(:properties) do
      add :slug, :string, null: false
      add :type, :integer, null: false
      add :city, :string, null: false
      add :state, :string, null: false
      add :address, :string, null: false
      add :address_number, :string, null: false
      add :complement, :string
      add :neighborhood, :string, null: false
      add :price, :float, null: false
      add :area, :float, null: false
      add :qty_rooms, :integer, null: false
      add :qty_bathrooms, :integer, null: false
      add :qty_kitchens, :integer, null: false
      add :qty_garages, :integer, null: false
      add :description, :text
      add :status, :integer, null: false

      timestamps()
    end

    create unique_index(:properties, [:slug])
  end
end
