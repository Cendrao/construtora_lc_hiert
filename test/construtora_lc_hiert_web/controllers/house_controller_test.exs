defmodule ConstrutoraLcHiertWeb.HouseControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase

  alias ConstrutoraLcHiert.Properties

  describe "GET /imoveis/casas" do
    test "accesses the page when there are houses", %{conn: conn} do
      property = property_fixture()

      conn = get(conn, "/imoveis/casas")

      assert html_response(conn, 200) =~ property.address
    end

    test "show no results found when there are no houses", %{conn: conn} do
      conn = get(conn, "/imoveis/casas")

      assert html_response(conn, 200) =~ "não foi encontrado nenhum resultado"
    end
  end

  def property_fixture(attrs \\ %{}) do
    {:ok, property} =
      attrs
      |> Enum.into(%{
        address: "Rua Carlos Barbosa",
        address_number: "1650",
        area: "50",
        city: "Toledo",
        neighborhood: "Vila Industrial",
        price: 1_000_000.0,
        qty_bathrooms: "3",
        qty_garages: "2",
        qty_kitchens: "2",
        qty_rooms: "4",
        state: "PR",
        type: :house
      })
      |> Properties.create_property()

    property
  end
end
