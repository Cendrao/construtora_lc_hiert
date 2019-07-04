defmodule ConstrutoraLcHiertWeb.SitemapControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase
  use ConstrutoraLcHiert.Fixtures, [:property]

  describe "GET /sitemap.xml" do
    test "accesses the sitemap in format xml", %{conn: conn} do
      property = property_fixture()

      conn = get(conn, "/sitemap.xml")

      assert response_content_type(conn, :xml)
      assert response(conn, 200) =~ ~r/<loc>.*#{property.slug}<\/loc>/
    end
  end
end
