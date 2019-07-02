defmodule ConstrutoraLcHiert.RealEstate.Properties.PropertiesAmenities do
  @moduledoc """
  The association between properties and amenities schema.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias ConstrutoraLcHiert.RealEstate.Properties.Property
  alias ConstrutoraLcHiert.RealEstate.Amenities.Amenity

  @primary_key false
  schema "properties_amenities" do
    belongs_to :property, Property
    belongs_to :amenity, Amenity
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:property_id, :amenity_id])
    |> validate_required([:property_id, :amenity_id])
  end
end
