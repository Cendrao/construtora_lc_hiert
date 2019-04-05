defmodule ConstrutoraLcHiertWeb.Admin.PageControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase

  describe "GET /admin" do
    @tag :sign_in_user
    test "accesses the admin page", %{conn: conn} do
      conn = get(conn, "/admin")
      assert html_response(conn, 200) =~ "Dashboard"
    end
  end
end
