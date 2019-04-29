defmodule ConstrutoraLcHiertWeb.LotControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase

  alias ConstrutoraLcHiert.Properties

  describe "GET /imoveis/lotes" do
    test "accesses the page when there are lots", %{conn: conn} do
      property = property_fixture()

      conn = get(conn, "/imoveis/lotes")

      assert html_response(conn, 200) =~ property.address
    end

    test "show no results found when there are no lots", %{conn: conn} do
      conn = get(conn, "/imoveis/lotes")

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
        price: 200_000.0,
        qty_bathrooms: "0",
        qty_garages: "0",
        qty_kitchens: "0",
        qty_rooms: "0",
        state: "PR",
        type: :lot
      })
      |> Properties.create_property()

    property
  end
end
