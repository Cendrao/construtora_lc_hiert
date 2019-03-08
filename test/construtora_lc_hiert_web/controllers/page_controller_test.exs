defmodule ConstrutoraLcHiertWeb.PageControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase

  describe "GET /" do
    test "accesses the home page", %{conn: conn} do
      conn = get(conn, "/")
      assert html_response(conn, 200) =~ "Welcome to Phoenix!"
    end
  end
end
