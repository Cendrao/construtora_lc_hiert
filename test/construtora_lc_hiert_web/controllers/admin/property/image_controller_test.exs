defmodule ConstrutoraLcHiertWeb.Admin.Property.ImageControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase
  use ConstrutoraLcHiert.Fixtures, [:property]

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.Storage
  alias ConstrutoraLcHiert.Storage.PropertyImage

  describe "GET /admin/imoveis/:id/fotos/new" do
    setup [:create_property]

    @tag :sign_in_user
    test "accesses the new property images page", %{conn: conn, property: property} do
      conn = get(conn, "/admin/imoveis/#{property.id}/fotos/new")

      assert html_response(conn, 200) =~ "Cadastrar Fotos de Imóvel"
    end
  end

  describe "POST /admin/imoveis/:id/fotos" do
    setup [:create_property]

    @tag :sign_in_user
    test "creates a new property image", %{conn: conn, property: property} do
      params = %{
        "image" => %Plug.Upload{
          path: "test/fixtures/images/aprovameupr.png",
          filename: "aprovameupr.png"
        },
        "property_id" => property.id
      }

      post(conn, "/admin/imoveis/#{property.id}/fotos", params)

      refute Repo.get_by(PropertyImage, property_id: property.id) == nil
    end
  end

  describe "DELETE /admin/imoveis/:id/fotos" do
    setup [:create_property]

    @tag :sign_in_user
    test "deletes the property image", %{conn: conn, property: property} do
      params = %{
        "image" => %Plug.Upload{
          path: "test/fixtures/images/aprovameupr.png",
          filename: "aprovameupr.png"
        },
        "property_id" => property.id
      }

      {:ok, property_image} = Storage.create_property_image(params)

      delete(conn, "/admin/imoveis/#{property.id}/fotos", %{image: property_image.id})

      assert Repo.get_by(PropertyImage, id: property_image.id, property_id: property.id) == nil
    end
  end

  defp create_property(_) do
    property = property_fixture()

    {:ok, property: property}
  end
end
