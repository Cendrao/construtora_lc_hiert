defmodule ConstrutoraLcHiert.StorageTest do
  use ConstrutoraLcHiert.DataCase
  use ConstrutoraLcHiert.Fixtures, [:property]

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.Storage
  alias ConstrutoraLcHiert.RealEstate.PropertyImages
  alias ConstrutoraLcHiert.RealEstate.Properties.PropertyImage

  describe "delete_property_image/1" do
    setup [:create_property]

    test "deletes the property_image and the file", %{property: property} do
      attrs = %{
        "image" => %Plug.Upload{
          path: "test/fixtures/images/aprovameupr.png",
          filename: "aprovameupr.png"
        },
        "property_id" => property.id
      }

      property_image = property_image_fixture(attrs)

      assert {:ok, %PropertyImage{}} = Storage.delete_property_image(property_image)
      assert_raise Ecto.NoResultsError, fn -> Repo.get!(PropertyImage, property_image.id) end
      refute File.exists?("uploads/test/#{property.id}/#{property_image.image.file_name}")
    end
  end

  describe "change_upload_image_filename/1" do
    setup [:create_property]

    test "changes the image filename", %{property: property} do
      attrs = %{
        "image" => %Plug.Upload{
          path: "test/fixtures/images/aprovameupr.png",
          filename: "aprovameupr.png"
        },
        "property_id" => property.id
      }

      file = Storage.change_upload_image_filename(attrs)

      assert file["image"].filename =~ ~r/construtora_lc_hiert_[0-9]*.png$/
    end
  end

  defp create_property(_) do
    property = property_fixture()

    {:ok, property: property}
  end

  def property_image_fixture(attrs) do
    {:ok, property_image} = PropertyImages.create_property_image(attrs)

    property_image
  end
end
