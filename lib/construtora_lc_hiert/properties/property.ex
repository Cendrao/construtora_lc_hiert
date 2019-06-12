defmodule ConstrutoraLcHiert.Properties.Property do
  use Ecto.Schema
  import Ecto.Changeset
  import EctoEnum

  alias ConstrutoraLcHiert.Properties.PropertySlug
  alias ConstrutoraLcHiert.EctoTypes.EctoPrice
  alias ConstrutoraLcHiert.PropertiesAmenities
  alias ConstrutoraLcHiert.Amenities.Amenity
  alias ConstrutoraLcHiert.Storage.PropertyImage

  @optional_params [:slug, :complement, :description, :status, :deleted_at]

  @required_params [
    :type,
    :city,
    :state,
    :neighborhood,
    :address,
    :address_number,
    :price,
    :area,
    :qty_rooms,
    :qty_bathrooms,
    :qty_kitchens,
    :qty_garages
  ]

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

  @doc false
  def changeset(property, attrs \\ %{}) do
    property
    |> cast(attrs, @required_params ++ @optional_params)
    |> validate_required(@required_params)
    |> PropertySlug.maybe_generate_slug()
    |> PropertySlug.unique_constraint()
  end
end
