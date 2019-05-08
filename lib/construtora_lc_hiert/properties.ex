defmodule ConstrutoraLcHiert.Properties do
  @moduledoc """
  The Properties context.
  """

  import Ecto.Query, warn: false

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.Properties.Property
  alias ConstrutoraLcHiert.Amenities

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking property changes.

  ## Examples

      iex> change_property(property)
      %Ecto.Changeset{source: %Property{}}

  """
  def change_property(%Property{} = property) do
    property
    |> Repo.preload(:amenities)
    |> Property.changeset(%{})
  end

  @doc """
  Creates a property.

  ## Examples

      iex> create_property(%{address: "Rua X", address_number: 6, city: "Toledo", ...}, [%Amenity{}])
      {:ok, %Property{}}

      iex> create_property(%{address: nil, address_number: nil, city: nil, ...}, [%Amenity{}])
      {:error, %Ecto.Changeset{}}

  """
  def create_property(attrs) do
    %Property{}
    |> Property.changeset(attrs)
    |> maybe_put_amenities(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a property.

  ## Examples

      iex> update_property(property, %{address: "Rua dos bobos"})
      {:ok, %Property{}}

      iex> update_property(property, %{address: nil})
      {:error, %Ecto.Changeset{}}

  """
  def update_property(%Property{} = property, attrs) do
    property
    |> Property.changeset(attrs)
    |> maybe_put_amenities(attrs)
    |> Repo.update()
  end

  @doc """
  Gets a single property.

  Raises `Ecto.NoResultsError` if the Property does not exist.

  ## Examples

      iex> get_property_by!(slug: "casa-rua-harmonia-942-sao-paulo-sp")
      %Property{}

      iex> get_property!(id)
      %Property{}

  """
  def get_property_by!(attrs) do
    Property
    |> Repo.get_by!(attrs)
    |> load_amenities()
    |> load_images()
  end

  def get_property!(id) do
    Property
    |> Repo.get!(id)
    |> load_amenities()
    |> load_images()
  end

  @doc """
  List all the cities available in the database

  ## Examples

      iex> list_cities()
      ["Toledo", "Umuarama"]

  """
  def list_cities() do
    Repo.all(
      from p in Property,
        distinct: p.city,
        where: is_nil(p.deleted_at),
        select: p.city
    )
  end

  @doc """
  List all the neighborhoods available in the database

  ## Examples

      iex> list_neighborhoods()
      ["Vila Industrial", "Jardim dos Príncipes", "Zona 2"]

  """
  def list_neighborhoods() do
    Repo.all(
      from p in Property,
        distinct: p.neighborhood,
        where: is_nil(p.deleted_at),
        select: p.neighborhood
    )
  end

  @doc """
  Returns the list of properties.

  ## Examples

      iex> list_properties()
      [%Property{}, ...]

      iex> list_properties(%{"type" => "apartment", "q" => "rua harmonia"})
      [%Property{}, ...]

      iex> list_featured_properties(3)
      [%Property{}, %Property{}, %Property{}]

  """
  def list_properties() do
    Property
    |> Property.default_query()
    |> Repo.all()
  end

  def list_properties(params, limit \\ nil) do
    Property
    |> Property.default_query()
    |> Property.search_query(params["q"])
    |> Property.city_query(params["city"])
    |> Property.neighborhood_query(params["neighborhood"])
    |> Property.min_area_query(params["min_area"])
    |> Property.max_area_query(params["max_area"])
    |> Property.qty_bathrooms_query(params["qty_bathrooms"])
    |> Property.qty_rooms_query(params["qty_rooms"])
    |> Property.type_query(params["type"])
    |> Property.limit_query(limit)
    |> Repo.all()
  end

  @doc """
  Soft deletes a Property.

  ## Examples

      iex> soft_delete_property(property)
      {:ok, %Property{}}

  """
  def soft_delete_property(%Property{} = property) do
    property
    |> Property.changeset(%{deleted_at: NaiveDateTime.utc_now()})
    |> Repo.update()
  end

  @doc """
  Preloads the amenities of a given property.

  ## Examples

      iex> load_amenities(property)
      %Property{..., amenities: [], ...}

  """
  def load_amenities(%Property{} = property), do: Repo.preload(property, :amenities)

  @doc """
  Preloads the images of a given property.

  ## Examples

      iex> load_images(property)
      %Property{..., images: [], ...}

  """
  def load_images(%Property{} = property), do: Repo.preload(property, :images)

  @doc """
  Translate the type to a human readable name.

  ## Examples

      iex> translate_type(:apartment)
      "Apartment"

  """
  def translate_type(:apartment), do: Gettext.gettext(ConstrutoraLcHiertWeb.Gettext, "Apartment")
  def translate_type(:house), do: Gettext.gettext(ConstrutoraLcHiertWeb.Gettext, "House")
  def translate_type(:lot), do: Gettext.gettext(ConstrutoraLcHiertWeb.Gettext, "Lot")

  defp maybe_put_amenities(changeset, []), do: changeset

  defp maybe_put_amenities(changeset, attrs) do
    amenities = Amenities.get_amenities(attrs["amenities"])

    Ecto.Changeset.put_assoc(changeset, :amenities, amenities)
  end
end
