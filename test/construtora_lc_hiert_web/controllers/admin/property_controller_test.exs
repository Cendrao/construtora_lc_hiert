defmodule ConstrutoraLcHiertWeb.Admin.PropertyControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.Properties.Property

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
    test "creates a new property with invalid params", %{conn: conn} do
      conn = post(conn, "/admin/imoveis", @invalid_params)

      assert html_response(conn, 200) =~ "Cadastrar Imóvel"

      assert html_response(conn, 200) =~
               "Oops! Ocorreu um problema. Por favor, resolva os erros abaixo."

      assert html_response(conn, 200) =~ "não pode ficar em branco"
    end
  end
end
