defmodule ConstrutoraLcHiertWeb.Admin.PropertyView do
  use ConstrutoraLcHiertWeb, :view

  alias ConstrutoraLcHiert.Properties
  alias ConstrutoraLcHiert.Properties.Property

  @doc """
  Creates an array to be used on the select tag of html.

  ## Example

      iex> property_types_for_select()
      [
        {"Apartamento", :apartment},
        {"Casa", :house},
        {"Lote", :lot}
      ]

  """
  def property_types_for_select do
    Property.TypeEnum.__enum_map__()
    |> Enum.map(fn {type, _} ->
      {translate_type(type), type}
    end)
  end

  def translate_type(type) do
    Properties.translate_type(type)
  end

  def address(property) do
    [property.address, property.address_number, property.complement]
    |> Enum.reject(&is_nil/1)
    |> Enum.join(", ")
  end
end
