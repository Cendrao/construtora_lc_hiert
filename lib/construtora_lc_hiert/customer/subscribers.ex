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

  def get_subscriber_by!(attrs) do
    Repo.get_by!(Subscriber, attrs)
  end

  def get_subscriber_by_email(nil), do: nil

  def get_subscriber_by_email(email) do
    Repo.get_by(Subscriber, email: email)
  end

  def list_subscribers do
    Repo.all(Subscriber)
  end

  def list_subscribers(:active) do
    Subscriber
    |> where([s], s.status == "active")
    |> Repo.all()
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
