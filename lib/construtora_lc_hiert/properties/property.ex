defmodule ConstrutoraLcHiert.Properties.Property do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
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

  @doc """
  Queries to be used to list properties

  ## Examples

      iex> Property.default_query(Property)
      [%Property{}, ...]

      iex> Property.type_query(Property, "apartment")
      [%Property{}, ...]

      iex> Property.search_query(Property, "rua harmonia")
      [%Property{}, ...]

  """
  def default_query(query) do
    from p in query,
      where: is_nil(p.deleted_at),
      left_join: images in assoc(p, :images),
      left_join: amenities in assoc(p, :amenities),
      preload: [images: images, amenities: amenities],
      order_by: [desc: p.updated_at]
  end

  def limit_query(query, nil), do: query

  def limit_query(query, value) do
    from p in query,
      limit: ^value
  end

  def search_query(query, nil), do: query

  def search_query(query, param) do
    from p in query,
      where: ilike(p.address, ^"%#{param}%"),
      or_where: ilike(p.city, ^"%#{param}%"),
      or_where: ilike(p.complement, ^"%#{param}%"),
      or_where: ilike(p.description, ^"%#{param}%"),
      or_where: ilike(p.neighborhood, ^"%#{param}%")
  end

  def city_query(query, nil), do: query

  def city_query(query, param) do
    from p in query,
      where: p.city == ^param
  end

  def neighborhood_query(query, nil), do: query

  def neighborhood_query(query, param) do
    from p in query,
      where: p.neighborhood == ^param
  end

  def min_area_query(query, nil), do: query

  def min_area_query(query, param) do
    from p in query,
      where: p.area >= ^param
  end

  def max_area_query(query, nil), do: query

  def max_area_query(query, param) do
    from p in query,
      where: p.area <= ^param
  end

  def type_query(query, nil), do: query

  def type_query(query, param) do
    from p in query,
      where: p.type == ^param
  end

  def qty_bathrooms_query(query, nil), do: query

  def qty_bathrooms_query(query, param) do
    from p in query,
      where: p.qty_bathrooms == ^param
  end

  def qty_rooms_query(query, nil), do: query

  def qty_rooms_query(query, param) do
    from p in query,
      where: p.qty_rooms == ^param
  end
end
