defmodule ConstrutoraLcHiert.Amenities.Amenity do
  use Ecto.Schema
  import Ecto.Changeset

  alias ConstrutoraLcHiert.PropertiesAmenities
  alias ConstrutoraLcHiert.Properties.Property

  schema "amenities" do
    field :name, :string

    many_to_many(:properties, Property, join_through: PropertiesAmenities)

    timestamps()
  end

  @doc false
  def changeset(amenity, attrs \\ %{}) do
    amenity
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
