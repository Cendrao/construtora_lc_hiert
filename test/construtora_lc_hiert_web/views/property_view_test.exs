defmodule ConstrutoraLcHiertWeb.PropertyViewTest do
  use ConstrutoraLcHiertWeb.ConnCase, async: true

  alias ConstrutoraLcHiertWeb.PropertyView

  test "full_address/1" do
    property = %{
      address: "Rua do Paraíso",
      address_number: "595",
      complement: nil,
      city: "São Paulo",
      state: "SP"
    }

    assert PropertyView.full_address(property) == "Rua do Paraíso, 595, São Paulo-SP"
  end
end
