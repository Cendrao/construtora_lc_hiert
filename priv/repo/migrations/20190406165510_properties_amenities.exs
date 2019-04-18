defmodule ConstrutoraLcHiert.Repo.Migrations.PropertiesAmenities do
  use Ecto.Migration

  def change do
    create table(:properties_amenities) do
      add :property_id, references(:properties, on_delete: :delete_all), null: false
      add :amenity_id, references(:amenities, on_delete: :delete_all), null: false
    end

    create unique_index(:properties_amenities, [:property_id, :amenity_id])
  end
end
