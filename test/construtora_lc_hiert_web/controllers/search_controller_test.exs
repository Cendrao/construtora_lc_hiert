defmodule ConstrutoraLcHiertWeb.SearchControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase
  use ConstrutoraLcHiert.Fixtures, [:property]

  describe "GET /imoveis/search" do
    test "accesses the page when there are results", %{conn: conn} do
      property = property_fixture()

      conn =
        get(conn, "/imoveis/busca", %{
          "q" => "barbosa",
          "max_area" => "60",
          "city" => "Toledo",
          "type" => "apartment",
          "qty_bathrooms" => "2"
        })

      assert html_response(conn, 200) =~ property.address
    end

    test "show no results found when there are no results", %{conn: conn} do
      conn = get(conn, "/imoveis/busca", %{"type" => "house"})

      assert html_response(conn, 200) =~ "não foi encontrado nenhum resultado"
    end
  end
end
