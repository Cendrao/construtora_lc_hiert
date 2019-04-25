defmodule ConstrutoraLcHiert.Amenities do
  @moduledoc """
  The Amenities context.
  """

  import Ecto.Query, warn: false

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.Amenities.Amenity

  @doc """
  Creates a amenity.

  ## Examples

      iex> create_amenity(%{name: "Piscina"})
      {:ok, %Amenity{}}

      iex> create_amenity(%{name: nil})
      {:error, %Ecto.Changeset{}}

  """
  def create_amenity(attrs \\ %{}) do
    %Amenity{}
    |> Amenity.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates an amenity.

  ## Examples

      iex> update_amenity(amenity, %{name: "Piscina"})
      {:ok, %Amenity{}}

      iex> update_amenity(amenity, %{name: nil})
      {:error, %Ecto.Changeset{}}

  """
  def update_amenity(%Amenity{} = amenity, attrs) do
    amenity
    |> Amenity.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Gets a single amenity.

  Raises `Ecto.NoResultsError` if the Amenity does not exist.

  ## Examples

      iex> get_amenity!(123)
      %Amenity{}

      iex> get_amenity!(456)
      ** (Ecto.NoResultsError)

  """
  def get_amenity!(id) do
    Repo.get!(Amenity, id)
  end

  @doc """
  Returns the list of amenities.

  ## Examples

      iex> list_amenities()
      [%Amenity{}, ...]

  """
  def list_amenities do
    Repo.all(Amenity)
  end

  @doc """
  Returns a list of amenities given its ids.

  ## Examples

      iex> get_amenities([1, 2])
      [%Amenity{}, %Amenity{}]

  """
  def get_amenities(nil), do: []

  def get_amenities(ids) do
    Repo.all(from a in Amenity, where: a.id in ^ids)
  end

  @doc """
  Hard deletes a Amenity.

  ## Examples

      iex> hard_delete_amenity(amenity)
      {:ok, %Amenity{}}

      iex> hard_delete_amenity(amenity)
      {:error, %Ecto.Changeset{}}

  """
  def hard_delete_amenity(%Amenity{} = amenity) do
    Repo.delete(amenity)
  end
end
