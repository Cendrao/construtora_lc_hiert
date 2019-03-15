defmodule ConstrutoraLcHiertWeb.AboutControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase

  describe "GET /quem-somos" do
    test "accesses the about page", %{conn: conn} do
      conn = get(conn, "/quem-somos")
      assert html_response(conn, 200) =~ "ALGUMAS PALAVRAS SOBRE"
    end
  end
end
