defmodule ConstrutoraLcHiertWeb.PropertyView do
  use ConstrutoraLcHiertWeb, :view

  def full_address(property) do
    "#{address(property)}, #{city(property)}"
  end

  defp address(property) do
    [property.address, property.address_number, property.complement]
    |> Enum.reject(&is_nil/1)
    |> Enum.join(", ")
  end

  defp city(property) do
    "#{property.city}-#{property.state}"
  end
end
