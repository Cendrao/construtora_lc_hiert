defmodule ConstrutoraLcHiertWeb.Admin.SubscriberControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase

  @tag :sign_in_user

  describe "GET /admin/inscritos" do
    test "accesses the subscribers page", %{conn: conn} do
      conn = get(conn, "/admin/inscritos")
      assert html_response(conn, 200) =~ "Inscritos"
    end
  end
end
