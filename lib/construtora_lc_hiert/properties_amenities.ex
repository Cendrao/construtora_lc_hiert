defmodule ConstrutoraLcHiert.PropertiesAmenities do
  use Ecto.Schema
  import Ecto.Changeset

  alias ConstrutoraLcHiert.Properties.Property
  alias ConstrutoraLcHiert.Amenities.Amenity

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
