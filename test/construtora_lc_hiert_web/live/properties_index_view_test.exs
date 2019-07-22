defmodule ConstrutoraLcHiertWeb.Live.Admin.PropertiesIndexViewTest do
  use ConstrutoraLcHiert.Fixtures, [:property]
  use ConstrutoraLcHiertWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "handle_event/3 to delete_property" do
    setup [:create_property]

    @tag :sign_in_user
    test "redirects to index page after deleting property", %{conn: conn, property: property} do
      {:ok, view, _html} = live(conn, Routes.admin_property_path(conn, :index))

      assert_redirect(view, "/admin/imoveis", fn ->
        assert render_click(view, :delete_property, property.id)
      end)
    end
  end

  defp create_property(_) do
    property = property_fixture()

    {:ok, property: property}
  end
end
