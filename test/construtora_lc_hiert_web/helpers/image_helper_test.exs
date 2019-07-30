defmodule ConstrutoraLcHiertWeb.Helpers.ImageHelperTest do
  use ConstrutoraLcHiertWeb.ConnCase, async: true

  alias ConstrutoraLcHiertWeb.Helpers.ImageHelper

  describe "image_url/2" do
    test "display the placeholder image url when given an empty list" do
      images = []
      opts = %{width: 360, height: 289}

      assert ImageHelper.image_url(images, opts) ==
               "https://placehold.it/360x289?text=Nenhuma+Imagem"
    end

    test "display the featured image url when given a list" do
      first_image = %{image: %{file_name: "pereba.jpg"}, property_id: 1, featured: false}
      second_image = %{image: %{file_name: "furuncu.jpg"}, property_id: 1, featured: true}
      third_image = %{image: %{file_name: "berne.jpg"}, property_id: 1, featured: false}

      images = [first_image, second_image, third_image]
      opts = %{width: 666, height: 333}

      assert ImageHelper.image_url(images, opts) == "/uploads/test/1/furuncu.jpg?tr=w-666,h-333"
    end

    test "display the url when given an image" do
      image = %{image: %{file_name: "juberlei.jpg"}, property_id: 2}
      opts = %{width: 64, height: 48}

      assert ImageHelper.image_url(image, opts) == "/uploads/test/2/juberlei.jpg?tr=w-64,h-48"
    end
  end
end
