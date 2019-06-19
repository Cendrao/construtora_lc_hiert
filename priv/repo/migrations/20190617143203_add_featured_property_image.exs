defmodule ConstrutoraLcHiert.Repo.Migrations.AddFeaturedPropertyImage do
  use Ecto.Migration

  def change do
    alter table("property_images") do
      add :featured, :boolean, default: false, null: false
    end

    create index(:property_images, [:featured])
  end
end
