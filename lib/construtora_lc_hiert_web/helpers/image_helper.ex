defmodule ConstrutoraLcHiertWeb.Helpers.ImageHelper do
  @moduledoc """
  Generate the URL of the image.

  ## Examples:

  When you pass a list of images it returns the featured image.

      iex> image_url(property.images, %{width: 100, height: 100})
      "/uploads/1/image.jpg"

  You can also pass an image like one item in the list of property.images

      iex> image_url(image, %{width: 100, height: 100})
      "/uploads/1/image.jpg"

  As we are using Imagekit (https://imagekit.io) to deal with the images in
  production, we have to pass the dimensions of the image.
  It's required because the images in production can be large, so passing the
  width and height, we can get compressed images.
  """

  alias ConstrutoraLcHiert.Storage.Uploaders.Image

  def image_url([], opts) do
    "https://placehold.it/#{opts[:width]}x#{opts[:height]}?text=Nenhuma+Imagem"
  end

  # Select the property's featured image
  def image_url(images, opts) when is_list(images) do
    image =
      images
      |> Enum.sort(fn i, _ -> i.featured end)
      |> List.first()

    image_url(image, opts)
  end

  def image_url(image, opts) do
    filename = Image.full_url(image)
    width = Map.fetch!(opts, :width)
    height = Map.fetch!(opts, :height)

    params = "tr=w-#{width},h-#{height}"

    "#{filename}?#{params}"
  end

  def image_url(image) do
    Image.full_url(image)
  end
end
