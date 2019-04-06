defmodule ConstrutoraLcHiert.Repo.Migrations.CreateAmenities do
  use Ecto.Migration

  def change do
    create table(:amenities) do
      add :name, :string, null: false

      timestamps()
    end
  end
end
