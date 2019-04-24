defmodule ConstrutoraLcHiertWeb.PropertyControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase

  alias ConstrutoraLcHiert.Properties

  describe "GET /imoveis/:slug" do
    setup [:create_property]

    test "accesses the property show page", %{conn: conn, property: property} do
      conn = get(conn, "/imoveis/#{property.slug}")

      assert String.match?(html_response(conn, 200), ~r/.*Detalhes.*Comodidades.*/s)
    end
  end

  defp create_property(_) do
    {:ok, property} =
      Properties.create_property(%{
        address: "Rua Carlos Barbosa",
        address_number: "1650",
        area: "50",
        city: "Toledo",
        neighborhood: "Vila Industrial",
        price: 1_000_000.0,
        qty_bathrooms: "2",
        qty_garages: "2",
        qty_kitchens: "1",
        qty_rooms: "3",
        state: "PR",
        type: :apartment
      })

    {:ok, property: property}
  end
end
