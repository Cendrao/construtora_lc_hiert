defmodule ConstrutoraLcHiertWeb.Admin.Property.ImageControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.Properties
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
          path: "test/fixtures/aprovameupr.png",
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
          path: "test/fixtures/aprovameupr.png",
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
