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

  describe "address/1" do
    test "display the address" do
      property = %{address: "Rua do Paraíso", address_number: "595", complement: "4º andar"}

      assert PropertyView.address(property) == "Rua do Paraíso, 595, 4º andar"
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

  describe "property_types_for_select/0" do
    test "returns a list of the available types" do
      assert PropertyView.property_types_for_select() == [
               {"Apartamento", :apartment},
               {"Casa", :house},
               {"Lote", :lot}
             ]
    end
  end

  describe "property_bathrooms_for_select/0" do
    test "returns a list of bathrooms quantity" do
      assert PropertyView.property_bathrooms_for_select() == %{
               "1 Banheiro": 1,
               "2 Banheiros": 2,
               "3 Banheiros": 3,
               "4 Banheiros": 4,
               "5 Banheiros": 5
             }
    end
  end

  describe "property_rooms_for_select/0" do
    test "returns a list of rooms quantity" do
      assert PropertyView.property_rooms_for_select() == %{
               "1 Quarto": 1,
               "2 Quartos": 2,
               "3 Quartos": 3,
               "4 Quartos": 4,
               "5 Quartos": 5
             }
    end
  end
end
