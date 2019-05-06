defmodule ConstrutoraLcHiertWeb.PropertyViewTest do
  use ConstrutoraLcHiertWeb.ConnCase, async: true

  alias ConstrutoraLcHiertWeb.PropertyView

  describe "full_address/1" do
    test "display the full address" do
      property = %{
        address: "Rua do Paraíso",
        address_number: "595",
        complement: nil,
        city: "São Paulo",
        state: "SP"
      }

      assert PropertyView.full_address(property) == "Rua do Paraíso, 595, São Paulo-SP"
    end
  end

  describe "city/1" do
    test "display the city and state" do
      property = %{city: "São Paulo", state: "SP"}

      assert PropertyView.city(property) == "São Paulo-SP"
    end
  end

  describe "description/1" do
    test "display the description of the property" do
      property = %{
        type: :apartment,
        address: "Rua Harmonia",
        address_number: "942",
        complement: nil,
        neighborhood: "Sumarezinho",
        city: "São Paulo",
        state: "SP"
      }

      assert PropertyView.description(property) ==
               "Apartamento em São Paulo-SP no bairro Sumarezinho - Rua Harmonia, 942"
    end
  end

  describe "translate_type/1" do
    test "display the translated type of the property" do
      assert PropertyView.translate_type(:apartment) == "Apartamento"
      assert PropertyView.translate_type(:house) == "Casa"
      assert PropertyView.translate_type(:lot) == "Lote"
    end
  end

  describe "image_url/2" do
    test "display the placeholder image url when given an empty list" do
      images = []
      opts = %{width: 360, height: 289}

      assert PropertyView.image_url(images, opts) ==
               "https://placehold.it/360x289?text=Nenhuma+Imagem"
    end

    test "display the featured image url when given a list" do
      image = %{image: %{file_name: "xablau.jpg"}, property_id: 1}
      images = [image]
      opts = %{width: 666, height: 333}

      assert PropertyView.image_url(images, opts) == "/uploads/test/1/xablau.jpg?tr=w-666,h-333"
    end

    test "display the url when given an image" do
      image = %{image: %{file_name: "juberlei.jpg"}, property_id: 2}
      opts = %{width: 64, height: 48}

      assert PropertyView.image_url(image, opts) == "/uploads/test/2/juberlei.jpg?tr=w-64,h-48"
    end
  end

  describe "image_class/2" do
    test "display the class of the image" do
      first_image = %{id: 1, image: %{file_name: "bi.jpg"}, property_id: 1}
      second_image = %{id: 2, image: %{file_name: "ri.jpg"}, property_id: 2}
      third_image = %{id: 3, image: %{file_name: "din.jpg"}, property_id: 3}

      images = [first_image, second_image, third_image]

      assert PropertyView.image_class(first_image, images) == "tab-pane fade in active"
      assert PropertyView.image_class(second_image, images) == "tab-pane fade"
      assert PropertyView.image_class(third_image, images) == "tab-pane fade"
    end
  end
end
