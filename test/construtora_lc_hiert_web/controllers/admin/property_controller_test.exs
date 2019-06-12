defmodule ConstrutoraLcHiertWeb.Admin.PropertyControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase
  use ConstrutoraLcHiert.Fixtures, [:property]

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.Properties.Property

  describe "GET /admin/imoveis" do
    @tag :sign_in_user
    test "accesses the properties page", %{conn: conn} do
      conn = get(conn, "/admin/imoveis")

      assert html_response(conn, 200) =~ "Imóveis"
    end
  end

  describe "GET /admin/imoveis/new" do
    @tag :sign_in_user
    test "accesses the new properties page", %{conn: conn} do
      conn = get(conn, "/admin/imoveis/new")

      assert html_response(conn, 200) =~ "Cadastrar Imóvel"
    end
  end

  describe "POST /admin/imoveis" do
    @tag :sign_in_user
    test "creates a new property with valid params", %{conn: conn} do
      post(conn, "/admin/imoveis", %{property: @valid_property_attrs})

      assert Repo.get_by!(Property,
               slug: "apartamento-rua-carlos-barbosa-1650-vila-industrial-toledo-pr"
             ).status == :for_sale
    end

    @tag :sign_in_user
    test "does not create a new property with invalid params", %{conn: conn} do
      conn = post(conn, "/admin/imoveis", %{property: @invalid_property_attrs})

      assert html_response(conn, 200) =~ "Cadastrar Imóvel"

      assert html_response(conn, 200) =~
               "Oops! Ocorreu um problema. Por favor, resolva os erros abaixo."

      assert html_response(conn, 200) =~ "não pode ficar em branco"
    end
  end

  describe "GET /admin/imoveis/:id/edit" do
    setup [:create_property]

    @tag :sign_in_user
    test "accesses the property edit page", %{conn: conn, property: property} do
      conn = get(conn, "/admin/imoveis/#{property.id}/edit")

      assert html_response(conn, 200) =~ "Alterar Imóvel"
    end
  end

  describe "PUT /admin/imoveis/:id" do
    setup [:create_property]

    @tag :sign_in_user
    test "updates the given property", %{conn: conn, property: property} do
      conn = put(conn, "/admin/imoveis/#{property.id}", %{property: @update_property_attrs})

      assert Repo.get_by(Property, address: "Rua Carlos Barbosa") == nil
      refute Repo.get_by(Property, address: "Rua do Paraíso") == nil

      assert redirected_to(conn) == "/admin/imoveis/#{property.id}/edit"
    end

    @tag :sign_in_user
    test "returns the error page when the params are invalid", %{conn: conn, property: property} do
      conn = put(conn, "/admin/imoveis/#{property.id}", %{property: @invalid_property_attrs})

      assert html_response(conn, 200) =~ "Alterar Imóvel"

      assert html_response(conn, 200) =~
               "Oops! Ocorreu um problema. Por favor, resolva os erros abaixo."

      assert html_response(conn, 200) =~ "não pode ficar em branco"
    end
  end

  describe "DELETE /admin/imoveis/:id" do
    setup [:create_property]

    @tag :sign_in_user
    test "deletes the user", %{conn: conn, property: property} do
      conn = delete(conn, "/admin/imoveis/#{property.id}")

      refute Repo.get(Property, property.id).deleted_at == nil

      assert get_flash(conn, :info) =~ "Excluído com sucesso"
      assert redirected_to(conn) == "/admin/imoveis"
    end
  end

  defp create_property(_) do
    property = property_fixture()

    {:ok, property: property}
  end
end
