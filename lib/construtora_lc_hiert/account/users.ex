defmodule ConstrutoraLcHiert.Account.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.Account.Users.User

  def list_users do
    User
    |> where([u], is_nil(u.deleted_at))
    |> where([u], u.master == false)
    |> Repo.all()
  end

  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Get a single user that is not deleted and with the given username.
  """
  def get_active_user_by_username(username) do
    User
    |> where([u], u.username == ^username)
    |> where([u], is_nil(u.deleted_at))
    |> Repo.one()
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> change_user(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> change_user(attrs)
    |> Repo.update()
  end

  def soft_delete_user(%User{} = user) do
    user
    |> change_user(%{deleted_at: NaiveDateTime.utc_now()})
    |> Repo.update()
  end

  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
