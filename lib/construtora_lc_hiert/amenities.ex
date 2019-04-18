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
end
