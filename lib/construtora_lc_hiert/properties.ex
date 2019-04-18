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
  Returns the list of properties.

  ## Examples

      iex> list_properties()
      [%Property{}, ...]

  """
  def list_properties do
    Repo.all(Property)
  end

  @doc """
  Preloads the amenities of a given property.

  ## Examples

      iex> load_amenities(property)
      %Property{..., amenities: [], ...}

  """
  def load_amenities(%Property{} = property) do
    Repo.preload(property, :amenities)
  end

  @doc """
  Translate the type to a readable name to the user.

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
