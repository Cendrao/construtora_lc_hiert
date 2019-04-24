defmodule ConstrutoraLcHiertWeb.PropertyView do
  use ConstrutoraLcHiertWeb, :view

  import Number.Currency

  def full_address(apartment) do
    "#{address(apartment)}, #{city(apartment)}"
  end

  defp address(apartment) do
    [apartment.address, apartment.address_number, apartment.complement]
    |> Enum.reject(&is_nil/1)
    |> Enum.join(", ")
  end

  defp city(apartment) do
    "#{apartment.city}-#{apartment.state}"
  end
end
