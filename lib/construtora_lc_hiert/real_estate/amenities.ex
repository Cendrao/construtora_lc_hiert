defmodule ConstrutoraLcHiert.RealEstate.Amenities do
  @moduledoc """
  The Amenities context.
  """

  import Ecto.Query, warn: false

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.RealEstate.Amenities.Amenity

  def create_amenity(attrs \\ %{}) do
    %Amenity{}
    |> change_amenity(attrs)
    |> Repo.insert()
  end

  def update_amenity(%Amenity{} = amenity, attrs) do
    amenity
    |> change_amenity(attrs)
    |> Repo.update()
  end

  def get_amenity!(id) do
    Repo.get!(Amenity, id)
  end

  @doc """
  Returns a list of aminities given a list of ids
  """
  def get_amenities(nil), do: []

  def get_amenities(ids) do
    Repo.all(from a in Amenity, where: a.id in ^ids)
  end

  def list_amenities do
    Repo.all(Amenity)
  end

  def hard_delete_amenity(%Amenity{} = amenity) do
    Repo.delete(amenity)
  end

  def change_amenity(%Amenity{} = amenity, attrs \\ %{}) do
    Amenity.changeset(amenity, attrs)
  end
end
