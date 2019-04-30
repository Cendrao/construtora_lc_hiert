defmodule ConstrutoraLcHiert.Repo.Migrations.AddDeletedAtOnProperties do
  use Ecto.Migration

  def change do
    alter table("properties") do
      add :deleted_at, :naive_datetime, default: nil
    end

    create index(:properties, [:deleted_at])
  end
end
