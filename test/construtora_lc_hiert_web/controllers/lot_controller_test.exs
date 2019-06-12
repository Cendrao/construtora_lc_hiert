defmodule ConstrutoraLcHiertWeb.LotControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase
  use ConstrutoraLcHiert.Fixtures, [:property]

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
end
