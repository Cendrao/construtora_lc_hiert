defmodule ConstrutoraLcHiertWeb.Admin.AmenityControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase
  use ConstrutoraLcHiert.Fixtures, [:amenity]

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.RealEstate.Amenities.Amenity

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
      post(conn, "/admin/comodidades", %{amenity: @valid_amenity_attrs})

      assert Repo.get_by!(Amenity, name: "Piscina")
    end

    @tag :sign_in_user
    test "creates a new amenity with invalid params", %{conn: conn} do
      conn = post(conn, "/admin/comodidades", %{amenity: @invalid_amenity_attrs})

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
      conn = put(conn, "/admin/comodidades/#{amenity.id}", %{amenity: @update_amenity_attrs})

      assert Repo.get_by(Amenity, name: "Piscina") == nil
      refute Repo.get_by(Amenity, name: "Ar condicionado") == nil

      assert redirected_to(conn) == "/admin/comodidades/#{amenity.id}/edit"
    end

    @tag :sign_in_user
    test "returns the error page when the params are invalid", %{conn: conn, amenity: amenity} do
      conn = put(conn, "/admin/comodidades/#{amenity.id}", %{amenity: @invalid_amenity_attrs})

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
    amenity = amenity_fixture()

    {:ok, amenity: amenity}
  end
end
