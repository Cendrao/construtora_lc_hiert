defmodule ConstrutoraLcHiert.Subscribers do
  @moduledoc """
  The Subscribers context.
  """

  import Ecto.Query, warn: false

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.Subscribers.Subscriber

  @doc """
  Creates a subscriber.

  ## Examples

      iex> create_subscriber(%{email: "ciro@bottini.com"})
      {:ok, %Subscriber{}}

      iex> create_subscriber(%{email: nil})
      {:error, %Ecto.Changeset{}}

  """
  def create_subscriber(attrs \\ %{}) do
    %Subscriber{}
    |> Subscriber.changeset(attrs)
    |> Repo.insert()
  end
end
