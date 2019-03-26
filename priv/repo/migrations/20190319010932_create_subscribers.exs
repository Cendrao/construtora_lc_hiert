defmodule ConstrutoraLcHiert.Repo.Migrations.CreateSubscribers do
  use Ecto.Migration

  def change do
    create table(:subscribers) do
      add :uuid, :uuid
      add :email, :string, null: false
      add :status, :string, default: "active", null: false

      timestamps()
    end

    create unique_index(:subscribers, [:email])
    create index(:subscribers, [:status])
  end
end
