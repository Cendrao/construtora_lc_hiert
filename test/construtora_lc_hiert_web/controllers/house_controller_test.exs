defmodule ConstrutoraLcHiertWeb.HouseControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase
  use ConstrutoraLcHiert.Fixtures, [:property]

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
end
