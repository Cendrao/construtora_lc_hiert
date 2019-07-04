defmodule ConstrutoraLcHiert.RealEstate.Properties.Property do
  @moduledoc """
  The property schema.
  """

  use Ecto.Schema

  import Ecto.Changeset
  import EctoEnum

  alias ConstrutoraLcHiert.RealEstate.Amenities.Amenity

  alias ConstrutoraLcHiert.RealEstate.Properties.{
    PropertySlug,
    EctoPrice,
    PropertiesAmenities,
    PropertyImage
  }

  @optional_params [:slug, :complement, :description, :status, :deleted_at]
  @required_params [:type, :city, :state, :neighborhood, :address, :address_number, :price, :area]
  @required_params_for_buildings [:qty_rooms, :qty_bathrooms, :qty_kitchens, :qty_garages]

  defenum(TypeEnum, apartment: 0, house: 1, lot: 2)
  defenum(StatusEnum, sold: 0, for_sale: 1)

  schema "properties" do
    field :address, :string
    field :address_number, :string
    field :area, :float
    field :city, :string
    field :complement, :string
    field :deleted_at, :naive_datetime, default: nil
    field :description, :string
    field :neighborhood, :string
    field :price, EctoPrice
    field :qty_bathrooms, :integer
    field :qty_garages, :integer
    field :qty_kitchens, :integer
    field :qty_rooms, :integer
    field :slug, PropertySlug.Type
    field :state, :string
    field :status, StatusEnum, default: :for_sale
    field :type, TypeEnum

    many_to_many(:amenities, Amenity, join_through: PropertiesAmenities, on_replace: :delete)
    has_many(:images, PropertyImage)

    timestamps()
  end

  def changeset(property, attrs \\ %{}) do
    property
    |> cast(attrs, @required_params ++ @optional_params ++ @required_params_for_buildings)
    |> validate_required(@required_params)
    |> validate_required_for_building(@required_params_for_buildings)
    |> PropertySlug.maybe_generate_slug()
    |> PropertySlug.unique_constraint()
  end

  @doc """
  It validates required fields for specific property type.

  If the property being created is a Lot it will just return the changeset.
  In any other cases, it will apply the given fields as required.
  """
  def validate_required_for_building(changeset, fields) do
    if get_field(changeset, :type) == :lot do
      changeset
    else
      validate_required(changeset, fields)
    end
  end
end
