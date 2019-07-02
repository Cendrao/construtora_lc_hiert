defmodule ConstrutoraLcHiert.RealEstate.Amenities.Amenity do
  @moduledoc """
  The amenities schema.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias ConstrutoraLcHiert.RealEstate.Properties.PropertiesAmenities
  alias ConstrutoraLcHiert.RealEstate.Properties.Property

  schema "amenities" do
    field :name, :string

    many_to_many(:properties, Property, join_through: PropertiesAmenities)

    timestamps()
  end

  def changeset(amenity, attrs \\ %{}) do
    amenity
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
