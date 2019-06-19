defmodule ConstrutoraLcHiert.Storage do
  @moduledoc """
  The Storage context.
  """

  import Ecto.Query, warn: false

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.Storage.PropertyImage
  alias ConstrutoraLcHiert.Storage.Uploaders.Image

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
  Gets a single property image.

  Raises `Ecto.NoResultsError` if the Property Image does not exist.

  ## Examples

      iex> get_property_image_by!(property_id: 1, image_id: 1)
      %PropertyImage{}

  """
  def get_property_image_by!(attrs), do: Repo.get_by!(PropertyImage, attrs)

  @doc """
  Deletes a PropertyImage.

  ## Examples

      iex> delete_property_image(property_image)
      {:ok, %PropertyImage{}}

      iex> delete_property_image(property_image)
      {:error, %Ecto.Changeset{}}

  """
  def delete_property_image(%PropertyImage{} = property_image) do
    Image.delete({property_image.image.file_name, property_image})
    Repo.delete(property_image)
  end

  @doc """
  Set an image as "featured"

  It will set all the images of the given property as `featured: false` and then
  set the selected image as `featured: true`. It is, only one image will be
  featured at a time.

  ## Examples

      iex> set_featured_property_image(property_image)
      {:ok, %PropertyImage{}}

      iex> set_featured_property_image(property_image)
      {:error, %Ecto.Changeset{}}

  """
  def set_featured_property_image(%PropertyImage{} = property_image) do
    PropertyImage
    |> where([p], p.property_id == ^property_image.property_id)
    |> Repo.update_all(set: [featured: false])

    property_image
    |> PropertyImage.changeset(%{featured: true})
    |> Repo.update()
  end
end
