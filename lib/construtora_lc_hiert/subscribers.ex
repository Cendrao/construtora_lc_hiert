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

  @doc """
  Gets a single subscriber.

  Raises `Ecto.NoResultsError` if the Subscriber does not exist.

  ## Examples

      iex> get_subscriber!(123)
      %Subscriber{}

      iex> get_subscriber!(456)
      ** (Ecto.NoResultsError)

  """
  def get_subscriber!(id) do
    Repo.get!(Subscriber, id)
  end

  @doc """
  Returns the list of subscribers.

  ## Examples

      iex> list_subscribers()
      [%Subscriber{}, ...]

  """
  def list_subscribers do
    Repo.all(Subscriber)
  end

  @doc """
  Activate or deactivate a single subscriber.

  ## Examples

      iex> activate_subscriber(subscriber)
      {:ok, %Subscriber{}}

      iex> deactivate_subscriber(subscriber)
      {:ok, %Subscriber{}}

  """
  def activate_subscriber(%Subscriber{} = subscriber) do
    subscriber
    |> Subscriber.changeset(%{status: "active"})
    |> Repo.update()
  end

  def deactivate_subscriber(%Subscriber{} = subscriber) do
    subscriber
    |> Subscriber.changeset(%{status: "inactive"})
    |> Repo.update()
  end
end
