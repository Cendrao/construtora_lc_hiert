defmodule ConstrutoraLcHiertWeb.Admin.Property.Image.FeaturedControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase
  use ConstrutoraLcHiert.Fixtures, [:property]

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.RealEstate.PropertyImages
  alias ConstrutoraLcHiert.RealEstate.Properties.PropertyImage

  describe "POST /admin/imoveis/:id/fotos/destaque" do
    setup [:create_property]

    @tag :sign_in_user
    test "sets a new property image as featured", %{conn: conn, property: property} do
      image =
        create_image_fixture(%{
          "image" => %Plug.Upload{
            path: "test/fixtures/images/aprovameupr.png",
            filename: "aprovameupr.png"
          },
          "property_id" => property.id,
          "featured" => false
        })

      params = %{"image" => image.id}

      conn = post(conn, "/admin/imoveis/#{property.id}/fotos/destaque", params)

      assert Repo.get(PropertyImage, image.id).featured == true
      assert redirected_to(conn) == "/admin/imoveis/#{property.id}/fotos/new"
    end
  end

  defp create_property(_) do
    property = property_fixture()

    {:ok, property: property}
  end

  def create_image_fixture(attrs) do
    {:ok, property_image} = PropertyImages.create_property_image(attrs)

    property_image
  end
end
