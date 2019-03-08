defmodule ConstrutoraLcHiertWeb.Admin.PageControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase

  alias ConstrutoraLcHiert.Accounts
  alias ConstrutoraLcHiert.Authentication.Guardian

  @valid_attrs %{username: "user", password: "password"}

  describe "GET /admin" do
    setup [:sign_in_user]

    test "accesses the admin page", %{conn: conn} do
      conn = get(conn, "/admin")
      assert html_response(conn, 200) =~ "Secret Page"
    end
  end

  defp sign_in_user(_) do
    {:ok, user} = Accounts.create_user(@valid_attrs)
    conn = Guardian.Plug.sign_in(build_conn(), user)

    {:ok, conn: conn}
  end
end
