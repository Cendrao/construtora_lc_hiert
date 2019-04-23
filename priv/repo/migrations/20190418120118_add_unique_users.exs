defmodule ConstrutoraLcHiert.Repo.Migrations.AddUniqueUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      modify :username, :string, null: false
      modify :password, :string, null: false
      add :master, :boolean, default: false, null: false
      add :deleted_at, :naive_datetime, default: nil
    end

    create unique_index(:users, [:username])
    create index(:users, [:deleted_at])
  end
end
