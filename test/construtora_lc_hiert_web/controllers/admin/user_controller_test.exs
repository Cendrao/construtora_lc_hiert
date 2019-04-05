defmodule ConstrutoraLcHiertWeb.Admin.UserControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase

  describe "GET /admin/usuarios" do
    @tag :sign_in_user
    test "accesses the users page", %{conn: conn} do
      conn = get(conn, "/admin/usuarios")
      assert html_response(conn, 200) =~ "Usuários"
    end
  end
end
