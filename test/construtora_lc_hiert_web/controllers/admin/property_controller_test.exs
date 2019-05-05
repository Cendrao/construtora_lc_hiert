defmodule ConstrutoraLcHiertWeb.Admin.PropertyControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.Properties.Property
  alias ConstrutoraLcHiert.Properties

  @valid_params %{
    property: %{
      address: "Rua Carlos Barbosa",
      address_number: "1650",
      area: "50",
      city: "Toledo",
      complement: "",
      description: "Lorem ipsum dolor sit amet.",
      neighborhood: "Vila Industrial",
      price: "1.000.000",
      qty_bathrooms: "2",
      qty_garages: "2",
      qty_kitchens: "1",
      qty_rooms: "3",
      state: "PR",
      type: :apartment,
      amenities: ["1", "2"]
    }
  }
  @update_params %{
    property: %{
      address: "Rua do Paraíso",
      address_number: "595",
      area: "150",
      city: "São Paulo",
      complement: "",
      description: "",
      neighborhood: "Paraíso",
      price: "2.000.000",
      qty_bathrooms: "4",
      qty_garages: "8",
      qty_kitchens: "1",
      qty_rooms: "1",
      state: "SP",
      type: :apartment,
      amenities: ["1"]
    }
  }
  @invalid_params %{
    property: %{
      address: "",
      address_number: "",
      area: "",
      city: "",
      complement: "",
      description: "",
      neighborhood: "",
      price: "",
      qty_bathrooms: "",
      qty_garages: "",
      qty_kitchens: "",
      qty_rooms: "",
      state: "",
      type: "",
      amenities: []
    }
  }

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
      post(conn, "/admin/imoveis", @valid_params)

      assert Repo.get_by!(Property,
               slug: "apartamento-rua-carlos-barbosa-1650-vila-industrial-toledo-pr"
             ).status == :for_sale
    end

    @tag :sign_in_user
    test "does not create a new property with invalid params", %{conn: conn} do
      conn = post(conn, "/admin/imoveis", @invalid_params)

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
      conn = put(conn, "/admin/imoveis/#{property.id}", @update_params)

      assert Repo.get_by(Property, address: "Rua Carlos Barbosa") == nil
      refute Repo.get_by(Property, address: "Rua do Paraíso") == nil

      assert redirected_to(conn) == "/admin/imoveis/#{property.id}/edit"
    end

    @tag :sign_in_user
    test "returns the error page when the params are invalid", %{conn: conn, property: property} do
      conn = put(conn, "/admin/imoveis/#{property.id}", @invalid_params)

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
    {:ok, property} =
      Properties.create_property(%{
        address: "Rua Carlos Barbosa",
        address_number: "1650",
        area: "50",
        city: "Toledo",
        neighborhood: "Vila Industrial",
        price: 1_000_000.0,
        qty_bathrooms: "2",
        qty_garages: "2",
        qty_kitchens: "1",
        qty_rooms: "3",
        state: "PR",
        type: :apartment
      })

    {:ok, property: property}
  end
end
