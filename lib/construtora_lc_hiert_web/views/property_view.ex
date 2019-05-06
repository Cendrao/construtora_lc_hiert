defmodule ConstrutoraLcHiertWeb.PropertyView do
  use ConstrutoraLcHiertWeb, :view

  alias ConstrutoraLcHiert.Properties
  alias ConstrutoraLcHiert.Storage.Uploaders.Image

  @doc """
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
  def image_url([], opts) do
    "https://placehold.it/#{opts[:width]}x#{opts[:height]}?text=Nenhuma+Imagem"
  end

  def image_url(images, opts) when is_list(images) do
    image = List.first(images)

    image_url(image, opts)
  end

  def image_url(image, opts) do
    filename = Image.full_url(image)
    width = Map.fetch!(opts, :width)
    height = Map.fetch!(opts, :height)

    params = "tr=w-#{width},h-#{height}"

    "#{filename}?#{params}"
  end

  @doc """
  It's used to get the classes of the big image in property#show
  The first item of the list will have a different classes than the others.

  ## Examples

      iex> image_class(first_image, images)
      "tab-pane fade in active"

      iex> image_class(second_image, images)
      "tab-pane fade"

  """
  def image_class(image, images) do
    if image == List.first(images) do
      "tab-pane fade in active"
    else
      "tab-pane fade"
    end
  end

  @doc """
  Display the full address of the property

  ## Examples

      iex> full_address(property)
      "Rua do Paraíso, 595, 4º andar, São Paulo-SP"

  """
  def full_address(property) do
    "#{address(property)}, #{city(property)}"
  end

  defp address(property) do
    [property.address, property.address_number, property.complement]
    |> Enum.reject(&is_nil/1)
    |> Enum.join(", ")
  end

  def city(property) do
    "#{property.city}-#{property.state}"
  end

  @doc """
  Display a description of the given property

  ## Examples

      iex> description(property)
      "Apartamento em Umuarama-PR no bairro Zona 1 - Av. Maringá, 123"

  """
  def description(property) do
    type = translate_type(property.type)
    city = city(property)
    neighborhood = property.neighborhood
    address = address(property)

    "#{type} em #{city} no bairro #{neighborhood} - #{address}"
  end

  @doc """
  Translate the type name of the property

  ## Examples

      iex> translate_type(:apartment)
      "Apartamento"

  """
  def translate_type(type) do
    Properties.translate_type(type)
  end
end
