defmodule ConstrutoraLcHiertWeb.PropertyView do
  use ConstrutoraLcHiertWeb, :view

  alias ConstrutoraLcHiert.RealEstate.Properties
  alias ConstrutoraLcHiert.RealEstate.Properties.Property

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

  def address(property) do
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

  def property_types_for_select() do
    Property.TypeEnum.__enum_map__()
    |> Enum.map(fn {type, _} ->
      {translate_type(type), type}
    end)
  end

  def property_bathrooms_for_select() do
    %{"1 Banheiro": 1, "2 Banheiros": 2, "3 Banheiros": 3, "4 Banheiros": 4, "5 Banheiros": 5}
  end

  def property_rooms_for_select() do
    %{"1 Quarto": 1, "2 Quartos": 2, "3 Quartos": 3, "4 Quartos": 4, "5 Quartos": 5}
  end

  @doc """
  Display property information of the given property

  ## Examples

      iex> property_information(property)
      "3 quarto(s) e 3 banheiro(s) - Bairro Alto de Pinheiros"
  """
  def property_information(%{type: :lot} = property) do
    "#{trunc(property.area)}m² - Bairro #{property.neighborhood}"
  end

  def property_information(%{} = property) do
    "#{property.qty_rooms} quarto(s) e #{property.qty_bathrooms} banheiro(s) - Bairro #{property.neighborhood}"
  end
      end
