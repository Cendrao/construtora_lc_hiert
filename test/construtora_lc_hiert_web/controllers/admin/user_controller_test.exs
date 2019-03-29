defmodule ConstrutoraLcHiertWeb.Admin.UserControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase

  @tag :sign_in_user

  describe "GET /admin/usuarios" do
    test "accesses the users page", %{conn: conn} do
      conn = get(conn, "/admin/usuarios")
      assert html_response(conn, 200) =~ "Usuários"
    end
  end
end
