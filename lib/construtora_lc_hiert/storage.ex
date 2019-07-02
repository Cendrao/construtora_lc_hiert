defmodule ConstrutoraLcHiert.Storage do
  @moduledoc """
  The Storage context.
  """

  import Ecto.Query, warn: false

  alias ConstrutoraLcHiert.RealEstate.Properties.PropertyImage
  alias ConstrutoraLcHiert.RealEstate.PropertyImages
  alias ConstrutoraLcHiert.Storage.Uploaders.Image

  @doc """
  Deletes a PropertyImage and the file in Storage.
  """
  def delete_property_image(%PropertyImage{} = property_image) do
    Image.delete({property_image.image.file_name, property_image})
    PropertyImages.delete_property_image(property_image)
  end

  @doc """
  Change the file name of the given image
  """
  def change_upload_image_filename(%{"image" => %Plug.Upload{filename: name} = image} = attrs) do
    image = %Plug.Upload{image | filename: create_filename(name)}
    %{attrs | "image" => image}
  end

  def change_upload_image_filename(attrs), do: attrs

  defp create_filename(name) do
    extension = Path.extname(name)

    "construtora_lc_hiert_#{:os.system_time()}" <> extension
  end
end
