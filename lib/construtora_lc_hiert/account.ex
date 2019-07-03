defmodule ConstrutoraLcHiert.Account do
  @moduledoc """
  The Account context.
  """

  alias Comeonin.Bcrypt
  alias ConstrutoraLcHiert.Account.Users

  @doc """
  Verify the user credentials to authentication.

  ## Examples

      iex> verify_user_credentials(username, password)
      {:ok, %User{}}

      iex> verify_user_credentials(username, wrong_password)
      {:error, :invalid_credentials}

      iex> verify_user_credentials(invalid_username, password)
      {:error, :not_found}

  """
  def verify_user_credentials(username, plain_text_password) do
    user = Users.get_active_user_by_username(username)

    cond do
      user && Bcrypt.checkpw(plain_text_password, user.password) ->
        {:ok, user}

      user ->
        {:error, :invalid_credentials}

      true ->
        Bcrypt.dummy_checkpw()
        {:error, :not_found}
    end
  end
end
