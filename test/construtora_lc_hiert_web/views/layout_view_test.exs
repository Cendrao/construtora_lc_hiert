defmodule ConstrutoraLcHiertWeb.LayoutViewTest do
  use ConstrutoraLcHiertWeb.ConnCase, async: true
  use ConstrutoraLcHiert.Fixtures, [:property]

  import Phoenix.HTML, only: [safe_to_string: 1]

  alias ConstrutoraLcHiertWeb.LayoutView

  @tag :sign_in_user
  test "current_user/1", %{conn: conn} do
    assert LayoutView.current_user(conn).username == "maico"
  end

  describe "active_class/2" do
    test "returns active when in the page" do
      conn = Phoenix.ConnTest.build_conn(:get, "/admin/properties", nil)

      assert LayoutView.active_class(conn, "/admin/properties") == "active"
      assert LayoutView.active_class(conn, "/admin/subscribers") == nil
      assert LayoutView.active_class(conn, "/admin") == nil
    end
  end

  describe "page_title/1" do
    test "returns the title for home page" do
      conn = get(build_conn(), "/")

      assert LayoutView.page_title(conn) == "Construtora LC Hiert"
    end

    test "returns the title for properties page" do
      conn = get(build_conn(), "/imoveis/apartamentos")

      assert LayoutView.page_title(conn) == "Imóveis à venda | Construtora LC Hiert"
    end

    test "returns the title for property page" do
      property = property_fixture()
      conn = get(build_conn(), "/imoveis/#{property.slug}")

      assert LayoutView.page_title(conn) ==
               "Apartamento - Vila Industrial - Toledo-PR | Construtora LC Hiert"
    end
  end

  describe "open_graph/1" do
    test "returns the open graphs for home page" do
      conn = get(build_conn(), "/")

      assert LayoutView.open_graph(conn) == nil
    end

    test "returns the open graphs for a property page" do
      property = property_fixture()
      conn = get(build_conn(), "/imoveis/#{property.slug}")

      open_graphs = conn |> LayoutView.open_graph() |> Enum.map(fn tag -> safe_to_string(tag) end)

      assert "<meta content=\"Construtora LC Hiert\" property=\"og:site_name\">" in open_graphs

      assert "<meta content=\"Apartamento - Vila Industrial - Toledo-PR | Construtora LC Hiert\" property=\"og:title\">" in open_graphs

      assert "<meta content=\"Apartamento em Toledo-PR no bairro Vila Industrial - Rua Carlos Barbosa, 1650 @ Construtora LC Hiert\" property=\"og:description\">" in open_graphs

      assert Enum.find(open_graphs, fn tag ->
               tag =~
                 ~r/<meta content=".*imoveis\/apartamento-rua-carlos-barbosa-1650-vila-industrial-toledo-pr.*property="og:url">/
             end)

      assert Enum.find(open_graphs, fn tag ->
               tag =~ ~r/<meta content="http.*property="og:image">/
             end)
    end
  end
end
