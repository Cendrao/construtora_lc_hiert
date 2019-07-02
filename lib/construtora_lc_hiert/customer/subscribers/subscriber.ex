defmodule ConstrutoraLcHiert.Customer.Subscribers.Subscriber do
  @moduledoc """
  The subscribers schema.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @possible_statuses ["active", "inactive"]

  schema "subscribers" do
    field :uuid, Ecto.UUID, autogenerate: true
    field :email, :string
    field :status, :string, default: "active"

    timestamps()
  end

  @doc false
  def changeset(subscriber, attrs) do
    subscriber
    |> cast(attrs, [:email, :status])
    |> validate_required([:email, :status])
    |> validate_inclusion(:status, @possible_statuses)
    |> unique_constraint(:email)
  end
end
