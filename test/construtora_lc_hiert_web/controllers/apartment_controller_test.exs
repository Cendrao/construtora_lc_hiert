defmodule ConstrutoraLcHiertWeb.ApartmentControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase

  describe "GET /imoveis/apartamentos" do
    test "accesses the apartments page", %{conn: conn} do
      conn = get(conn, "/imoveis/apartamentos")

      assert html_response(conn, 200)
    end
  end
end
