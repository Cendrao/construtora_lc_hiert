defmodule ConstrutoraLcHiertWeb.ApartmentControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase
  use ConstrutoraLcHiert.Fixtures, [:property]

  describe "GET /imoveis/apartamentos" do
    test "accesses the page when there are apartments", %{conn: conn} do
      property = property_fixture()

      conn = get(conn, "/imoveis/apartamentos")

      assert html_response(conn, 200) =~ property.address
    end

    test "show no results found when there are no apartments", %{conn: conn} do
      conn = get(conn, "/imoveis/apartamentos")

      assert html_response(conn, 200) =~ "não foi encontrado nenhum resultado"
    end
  end
end
