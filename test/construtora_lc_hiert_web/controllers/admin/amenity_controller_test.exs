defmodule ConstrutoraLcHiertWeb.Admin.AmenityControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.Amenities.Amenity

  @valid_params %{amenity: %{name: "Ar condicionado"}}
  @invalid_params %{amenity: %{name: ""}}

  describe "GET /admin/comodidades" do
    @tag :sign_in_user
    test "accesses the amenities page", %{conn: conn} do
      conn = get(conn, "/admin/comodidades")
      assert html_response(conn, 200) =~ "Comodidades"
    end
  end

  describe "GET /admin/comodidades/new" do
    @tag :sign_in_user
    test "accesses the new amenities page", %{conn: conn} do
      conn = get(conn, "/admin/comodidades/new")
      assert html_response(conn, 200) =~ "Cadastrar Comodidade"
    end
  end

  describe "POST /admin/comodidades" do
    @tag :sign_in_user
    test "creates a new amenity with valid params", %{conn: conn} do
      post(conn, "/admin/comodidades", @valid_params)

      assert Repo.get_by!(Amenity, name: "Ar condicionado")
    end

    @tag :sign_in_user
    test "creates a new amenity with invalid params", %{conn: conn} do
      conn = post(conn, "/admin/comodidades", @invalid_params)

      assert html_response(conn, 200) =~ "Cadastrar Comodidade"

      assert html_response(conn, 200) =~
               "Oops! Ocorreu um problema. Por favor, resolva os erros abaixo."

      assert html_response(conn, 200) =~ "não pode ficar em branco"
    end
  end
end
