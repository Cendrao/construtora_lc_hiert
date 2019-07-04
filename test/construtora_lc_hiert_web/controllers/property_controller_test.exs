defmodule ConstrutoraLcHiertWeb.PropertyControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase
  use ConstrutoraLcHiert.Fixtures, [:property]

  describe "GET /imoveis/:slug" do
    setup [:create_property]

    test "accesses the property show page", %{conn: conn, property: property} do
      conn = get(conn, "/imoveis/#{property.slug}")

      assert html_response(conn, 200) =~ ~r/Detalhes.*#{property.address}/s
    end
  end

  defp create_property(_) do
    property = property_fixture()

    {:ok, property: property}
  end
end
