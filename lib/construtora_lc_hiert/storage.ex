defmodule ConstrutoraLcHiert.Storage do
  @moduledoc """
  The Storage context.
  """

  import Ecto.Query, warn: false
  alias ConstrutoraLcHiert.Repo

  alias ConstrutoraLcHiert.Storage.PropertyImage

  @doc """
  Creates a property_image.

  ## Examples

      iex> create_property_image(%{image: %Plug.Upload{}, property_id: 64})
      {:ok, %PropertyImage{}}

      iex> create_property_image(%{image: %Plug.Upload{}, property_id: nil})
      {:error, %Ecto.Changeset{}}

  """
  def create_property_image(attrs \\ %{}) do
    %PropertyImage{}
    |> PropertyImage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes a PropertyImage.

  ## Examples

      iex> delete_property_image(property_image)
      {:ok, %PropertyImage{}}

      iex> delete_property_image(property_image)
      {:error, %Ecto.Changeset{}}

  """
  def delete_property_image(%PropertyImage{} = property_image) do
    Repo.delete(property_image)
  end
end
