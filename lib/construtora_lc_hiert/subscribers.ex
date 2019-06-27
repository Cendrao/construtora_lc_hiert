defmodule ConstrutoraLcHiert.Subscribers do
  @moduledoc """
  The Subscribers context.
  """

  import Ecto.Query, warn: false

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.Subscribers.Subscriber

  def create_subscriber(attrs \\ %{}) do
    %Subscriber{}
    |> Subscriber.changeset(attrs)
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
    |> Subscriber.changeset(%{status: "active"})
    |> Repo.update()
  end

  def deactivate_subscriber(%Subscriber{} = subscriber) do
    subscriber
    |> Subscriber.changeset(%{status: "inactive"})
    |> Repo.update()
  end

  def count_subscribers do
    Subscriber
    |> where([p], p.status == "active")
    |> select([p], count(p.id))
    |> Repo.one()
  end
end
