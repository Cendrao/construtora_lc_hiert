defmodule ConstrutoraLcHiertWeb.LayoutViewTest do
  use ConstrutoraLcHiertWeb.ConnCase, async: true

  alias ConstrutoraLcHiertWeb.LayoutView

  @tag :sign_in_user
  test "current_user/1", %{conn: conn} do
    assert LayoutView.current_user(conn).username == "mike"
  end

  describe "active_class/2" do
    test "returns active when in the page" do
      conn = Phoenix.ConnTest.build_conn(:get, "/admin/properties", nil)

      assert LayoutView.active_class(conn, "/admin/properties") == "active"
      assert LayoutView.active_class(conn, "/admin/subscribers") == nil
      assert LayoutView.active_class(conn, "/admin") == nil
    end
  end
end
