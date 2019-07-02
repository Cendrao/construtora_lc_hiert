defmodule ConstrutoraLcHiert.Customer.Subscribers do
  @moduledoc """
  The Subscribers context.
  """

  import Ecto.Query, warn: false

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.Customer.Subscribers.Subscriber

  def create_subscriber(attrs \\ %{}) do
    %Subscriber{}
    |> change_subscriber(attrs)
    |> Repo.insert()
  end

  def get_subscriber!(id) do
    Repo.get!(Subscriber, id)
  end

  def list_subscribers do
    Repo.all(Subscriber)
  end

  def activate_subscriber(%Subscriber{} = subscriber) do
    subscriber
    |> change_subscriber(%{status: "active"})
    |> Repo.update()
  end

  def deactivate_subscriber(%Subscriber{} = subscriber) do
    subscriber
    |> change_subscriber(%{status: "inactive"})
    |> Repo.update()
  end

  def change_subscriber(%Subscriber{} = subscriber, attrs \\ %{}) do
    Subscriber.changeset(subscriber, attrs)
  end

  @doc """
  Count all the subscribers that are active.
  """
  def count_subscribers do
    Subscriber
    |> where([p], p.status == "active")
    |> select([p], count(p.id))
    |> Repo.one()
  end
end
