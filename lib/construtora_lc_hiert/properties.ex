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
  Gets a single property.

  Raises `Ecto.NoResultsError` if the Property does not exist.

  ## Examples

      iex> get_property_by!(id)
      %Property{}

  """
  def get_property_by!(attrs) do
    Property
    |> Repo.get_by!(attrs)
    |> load_amenities()
  end

  @doc """
  Returns the list of properties.

  ## Examples

      iex> list_properties()
      [%Property{}, ...]

      iex> list_properties(:apartment)
      [%Property{}, ...]

      iex> list_featured_properties(3)
      [%Property{}, %Property{}, %Property{}]

  """
  def list_properties(), do: Repo.all(Property)

  def list_properties(type) do
    Repo.all(from p in Property, where: p.type == ^type)
  end

  def list_featured_properties(limit \\ 3) do
    Repo.all(from p in Property, limit: ^limit, order_by: [desc: p.updated_at])
  end

  @doc """
  Preloads the amenities of a given property.

  ## Examples

      iex> load_amenities(property)
      %Property{..., amenities: [], ...}

  """
  def load_amenities(%Property{} = property), do: Repo.preload(property, :amenities)

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
