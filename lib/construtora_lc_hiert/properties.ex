defmodule ConstrutoraLcHiert.Properties do
  @moduledoc """
  The Properties context.
  """

  import Ecto.Query, warn: false

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.Properties.Property
  alias ConstrutoraLcHiert.Amenities
  alias ConstrutoraLcHiert.Paginator
  alias ConstrutoraLcHiert.Filters

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking property changes.

  ## Examples

      iex> change_property(property)
      %Ecto.Changeset{source: %Property{}}

  """
  def change_property(%Property{} = property) do
    property
    |> load_amenities()
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
  List all the data available in the database

  ## Examples

      iex> list_cities()
      ["Toledo", "Umuarama"]

      iex> list_neighborhoods()
      ["Vila Industrial", "Jardim dos Príncipes", "Zona 2"]

  """
  def list_cities() do
    Property
    |> where([p], is_nil(p.deleted_at))
    |> distinct([p], p.city)
    |> select([p], p.city)
    |> Repo.all()
  end

  def list_neighborhoods() do
    Property
    |> where([p], is_nil(p.deleted_at))
    |> distinct([p], p.neighborhood)
    |> select([p], p.neighborhood)
    |> Repo.all()
  end

  @doc """
  Returns the list of properties.

  You can choose if you want to return paged results, or all results.
  If you use `list_paged_properties(params)` it will add a limit and offset in
  the query and return just a part of the results.

  ## Examples

      iex> list_paged_properties(%{"page" => 1})
      { list: [%Property{id: 1}, %Property{id: 2}, %Property{id: 3}], page: 1, ... }

      iex> list_paged_properties(%{"page" => 2})
      { list: [%Property{id: 4}, %Property{id: 5}, %Property{id: 6}], page: 2, ... }

      iex> list_paged_properties(%{"type" => "apartment", "page" => 1})
      { list: [%Property{id: 1}, %Property{id: 3}, %Property{id: 6}], page: 1, ... }


  But if you want to return all the results of the query at once, you can use
  `list_properties()`.

  ## Examples

      iex> list_properties()
      [%Property{}, %Property{}, %Property{}, %Property{}, %Property{}, ...]

      iex> list_properties(%{"type" => "apartment", "q" => "rua harmonia"})
      [%Property{}, %Property{}, ...]

  """
  def list_paged_properties(params) do
    Property
    |> where([p], is_nil(p.deleted_at))
    |> order_by([p], desc: p.updated_at)
    |> preload([:images, :amenities])
    |> Filters.apply(params)
    |> Paginator.paginate(params["page"])
  end

  def list_properties() do
    Property
    |> where([p], is_nil(p.deleted_at))
    |> order_by([p], desc: p.updated_at)
    |> join(:left, [p], a in assoc(p, :amenities), as: :amenities)
    |> join(:left, [p], i in assoc(p, :images), as: :images)
    |> preload([amenities: a, images: i], amenities: a, images: i)
    |> Repo.all()
  end

  def list_properties(params) do
    Property
    |> where([p], is_nil(p.deleted_at))
    |> order_by([p], desc: p.updated_at)
    |> preload([:images, :amenities])
    |> Filters.apply(params)
    |> Repo.all()
  end

  def list_properties(params, limit) do
    Property
    |> where([p], is_nil(p.deleted_at))
    |> order_by([p], desc: p.updated_at)
    |> preload([:images, :amenities])
    |> limit(^limit)
    |> Filters.apply(params)
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
  Preloads the associations of a given property.

  ## Examples

      iex> load_amenities(property)
      %Property{..., amenities: [], ...}

      iex> load_images(property)
      %Property{..., images: [], ...}

  """
  def load_amenities(property), do: Repo.preload(property, :amenities)
  def load_images(property), do: Repo.preload(property, :images)

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
