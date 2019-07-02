defmodule ConstrutoraLcHiert.RealEstate.PropertyImages do
  @moduledoc """
  The Property Image context.
  """

  import Ecto.Query, warn: false

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.RealEstate.Properties.PropertyImage

  def create_property_image(attrs \\ %{}) do
    %PropertyImage{}
    |> change_property_image(attrs)
    |> Repo.insert()
  end

  def get_property_image_by!(attrs), do: Repo.get_by!(PropertyImage, attrs)

  def delete_property_image(%PropertyImage{} = property_image) do
    Repo.delete(property_image)
  end

  def change_property_image(%PropertyImage{} = property_image, attrs \\ %{}) do
    PropertyImage.changeset(property_image, attrs)
  end

  @doc """
  Set an image as "featured"

  It will set all the images of the given property as `featured: false` and then
  set the selected image as `featured: true`. It is, only one image will be
  featured at a time.
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
