defmodule ConstrutoraLcHiert.RealEstate.Properties do
  @moduledoc """
  The Properties context.
  """

  import Ecto.Query, warn: false

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.Paginator
  alias ConstrutoraLcHiert.RealEstate.Properties.Property
  alias ConstrutoraLcHiert.RealEstate.{Amenities, Filters}

  def create_property(attrs) do
    %Property{}
    |> change_property(attrs)
    |> maybe_put_amenities(attrs)
    |> Repo.insert()
  end

  def update_property(%Property{} = property, attrs) do
    property
    |> change_property(attrs)
    |> maybe_put_amenities(attrs)
    |> Repo.update()
  end

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
  List all the data available in the database (grouped)
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

      iex> list_paged_properties(%{page: 1})
      { list: [%Property{id: 1}, %Property{id: 2}, %Property{id: 3}], page: 1, ... }

      iex> list_paged_properties(%{page: 2})
      { list: [%Property{id: 4}, %Property{id: 5}, %Property{id: 6}], page: 2, ... }

      iex> list_paged_properties(%{type: :apartment, page: 1})
      { list: [%Property{id: 1}, %Property{id: 3}, %Property{id: 6}], page: 1, ... }


  But if you want to return all the results of the query at once, you can use
  `list_properties()`.

  ## Examples

      iex> list_properties()
      [%Property{}, %Property{}, %Property{}, %Property{}, %Property{}, ...]

      iex> list_properties(%{type: :apartment, q: "rua harmonia"})
      [%Property{}, %Property{}, ...]

  """
  def list_paged_properties(params) do
    Property
    |> where([p], is_nil(p.deleted_at))
    |> order_by([p], desc: p.updated_at)
    |> preload([:images, :amenities])
    |> Filters.apply(params)
    |> Paginator.paginate(params[:page])
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

  def soft_delete_property(%Property{} = property) do
    property
    |> change_property(%{deleted_at: NaiveDateTime.utc_now()})
    |> Repo.update()
  end

  def change_property(%Property{} = property, attrs \\ %{}) do
    Property.changeset(property, attrs)
  end

  @doc """
  Count the active properties given its type.
  """
  def count_properties(type) do
    Property
    |> where([p], is_nil(p.deleted_at))
    |> where([p], p.type == ^type)
    |> select([p], count(p.id))
    |> Repo.one()
  end

  def get_cheapest_property(type) do
    Property
    |> where([p], is_nil(p.deleted_at))
    |> where([p], p.type == ^type)
    |> first(:price)
    |> Repo.one()
  end

  def get_most_expensive_property(type) do
    Property
    |> where([p], is_nil(p.deleted_at))
    |> where([p], p.type == ^type)
    |> last(:price)
    |> Repo.one()
  end

  def properties_avg_price(type) do
    Property
    |> where([p], is_nil(p.deleted_at))
    |> where([p], p.type == ^type)
    |> select([p], avg(p.price))
    |> Repo.one()
  end

  def properties_price_sum do
    Property
    |> where([p], is_nil(p.deleted_at))
    |> select([p], sum(p.price))
    |> Repo.one()
  end

  def load_amenities(property), do: Repo.preload(property, :amenities)
  def load_images(property), do: Repo.preload(property, :images)

  def translate_type(:apartment), do: Gettext.gettext(ConstrutoraLcHiertWeb.Gettext, "Apartment")
  def translate_type(:house), do: Gettext.gettext(ConstrutoraLcHiertWeb.Gettext, "House")
  def translate_type(:lot), do: Gettext.gettext(ConstrutoraLcHiertWeb.Gettext, "Lot")

  defp maybe_put_amenities(changeset, []), do: changeset

  defp maybe_put_amenities(changeset, attrs) do
    selected_amenities = attrs["amenities"] || attrs[:amenities]
    amenities = Amenities.get_amenities(selected_amenities)

    Ecto.Changeset.put_assoc(changeset, :amenities, amenities)
  end
end
