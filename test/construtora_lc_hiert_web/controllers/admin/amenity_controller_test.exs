defmodule ConstrutoraLcHiertWeb.Admin.AmenityControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.Amenities.Amenity
  alias ConstrutoraLcHiert.Amenities

  @valid_params %{amenity: %{name: "Ar condicionado"}}
  @update_params %{amenity: %{name: "Piscina"}}
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

  describe "GET /admin/comodidades/:id/edit" do
    setup [:create_amenity]

    @tag :sign_in_user
    test "accesses the amenities edit page", %{conn: conn, amenity: amenity} do
      conn = get(conn, "/admin/comodidades/#{amenity.id}/edit")

      assert html_response(conn, 200) =~ "Alterar Comodidade"
    end
  end

  describe "PUT /admin/comodidades/:id" do
    setup [:create_amenity]

    @tag :sign_in_user
    test "updates the given amenity", %{conn: conn, amenity: amenity} do
      conn = put(conn, "/admin/comodidades/#{amenity.id}", @update_params)

      assert Repo.get_by(Amenity, name: "Ar condicionado") == nil
      refute Repo.get_by(Amenity, name: "Piscina") == nil

      assert redirected_to(conn) == "/admin/comodidades/#{amenity.id}/edit"
    end

    @tag :sign_in_user
    test "returns the error page when the params are invalid", %{conn: conn, amenity: amenity} do
      conn = put(conn, "/admin/comodidades/#{amenity.id}", @invalid_params)

      assert html_response(conn, 200) =~ "Alterar Comodidade"

      assert html_response(conn, 200) =~
               "Oops! Ocorreu um problema. Por favor, resolva os erros abaixo."

      assert html_response(conn, 200) =~ "não pode ficar em branco"
    end
  end

  describe "DELETE /admin/comodidades/:id" do
    setup [:create_amenity]

    @tag :sign_in_user
    test "deletes the amenity", %{conn: conn, amenity: amenity} do
      conn = delete(conn, "/admin/comodidades/#{amenity.id}")

      assert Repo.get_by(Amenity, name: amenity.name) == nil

      assert get_flash(conn, :info) =~ "Excluído com sucesso"
      assert redirected_to(conn) == "/admin/comodidades"
    end
  end

  defp create_amenity(_) do
    {:ok, amenity} = Amenities.create_amenity(%{name: "Piscina"})
    {:ok, amenity: amenity}
  end
end
