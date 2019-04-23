defmodule ConstrutoraLcHiert.Accounts.User do
  @moduledoc """
  The users context.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Comeonin.Bcrypt

  schema "users" do
    field :password, :string
    field :username, :string
    field :master, :boolean, default: false
    field :deleted_at, :naive_datetime, default: nil

    timestamps()
  end

  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:username, :password, :master, :deleted_at])
    |> validate_required([:username, :password])
    |> unique_constraint(:username)
    |> validate_length(:password, min: 5)
    |> validate_confirmation(:password)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password, Bcrypt.hashpwsalt(password))

      _ ->
        changeset
    end
  end
end
