defmodule ConstrutoraLcHiert.PropertiesTest do
  use ConstrutoraLcHiert.DataCase

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.Amenities
  alias ConstrutoraLcHiert.Properties
  alias ConstrutoraLcHiert.Properties.Property

  @valid_attrs %{
    "address" => "Rua Carlos Barbosa",
    "address_number" => "1650",
    "area" => "50",
    "city" => "Toledo",
    "complement" => "",
    "description" => "Lorem ipsum dolor sit amet.",
    "neighborhood" => "Vila Industrial",
    "price" => "1.000.000",
    "qty_bathrooms" => "2",
    "qty_garages" => "2",
    "qty_kitchens" => "1",
    "qty_rooms" => "3",
    "state" => "PR",
    "type" => :apartment
  }
  @update_attrs %{
    "address" => "Rua do Paraíso",
    "address_number" => "595",
    "area" => "150",
    "city" => "São Paulo",
    "complement" => "",
    "description" => "",
    "neighborhood" => "Paraíso",
    "price" => "2.000.000",
    "qty_bathrooms" => "4",
    "qty_garages" => "8",
    "qty_kitchens" => "1",
    "qty_rooms" => "1",
    "state" => "SP",
    "type" => :apartment
  }
  @invalid_attrs %{
    "address" => nil,
    "address_number" => nil,
    "area" => nil,
    "city" => nil,
    "complement" => nil,
    "description" => nil,
    "neighborhood" => nil,
    "price" => nil,
    "qty_bathrooms" => nil,
    "qty_garages" => nil,
    "qty_kitchens" => nil,
    "qty_rooms" => nil,
    "state" => nil,
    "type" => nil
  }

  def property_fixture(attrs \\ %{}) do
    {:ok, property} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Properties.create_property()

    Properties.load_images(property)
  end

  def amenity_fixture(attrs \\ %{}) do
    {:ok, amenity} =
      attrs
      |> Enum.into(%{name: "Piscina"})
      |> Amenities.create_amenity()

    amenity
  end

  test "change_property/1 returns a property changeset" do
    property = property_fixture()

    assert %Ecto.Changeset{} = Properties.change_property(property)
  end

  describe "create_property/2" do
    test "with valid data creates a property" do
      assert {:ok, %Property{} = property} = Properties.create_property(@valid_attrs)

      assert %Property{
               address: "Rua Carlos Barbosa",
               address_number: "1650",
               area: 50.0,
               city: "Toledo",
               state: "PR",
               complement: nil,
               description: "Lorem ipsum dolor sit amet.",
               neighborhood: "Vila Industrial",
               price: "1.000.000",
               qty_bathrooms: 2,
               qty_garages: 2,
               qty_kitchens: 1,
               qty_rooms: 3,
               type: :apartment,
               status: :for_sale,
               slug: "apartamento-rua-carlos-barbosa-1650-vila-industrial-toledo-pr"
             } = property
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{} = changeset} = Properties.create_property(@invalid_attrs)

      assert %{
               address: ["can't be blank"],
               address_number: ["can't be blank"],
               area: ["can't be blank"],
               city: ["can't be blank"],
               neighborhood: ["can't be blank"],
               price: ["can't be blank"],
               qty_bathrooms: ["can't be blank"],
               qty_garages: ["can't be blank"],
               qty_kitchens: ["can't be blank"],
               qty_rooms: ["can't be blank"],
               state: ["can't be blank"],
               type: ["can't be blank"]
             } = errors_on(changeset)
    end
  end

  describe "update_property/2" do
    test "with valid data updates the property" do
      property = property_fixture()

      assert {:ok, %Property{} = property} = Properties.update_property(property, @update_attrs)

      assert %Property{
               address: "Rua do Paraíso",
               address_number: "595",
               area: 150.0,
               city: "São Paulo",
               complement: nil,
               description: nil,
               neighborhood: "Paraíso",
               price: "2.000.000",
               qty_bathrooms: 4,
               qty_garages: 8,
               qty_kitchens: 1,
               qty_rooms: 1,
               state: "SP",
               type: :apartment
             } = property
    end

    test "updates when adding amenities" do
      amenity = amenity_fixture()
      property = property_fixture()
      attrs = Map.put(@update_attrs, "amenities", [amenity.id])

      assert {:ok, %Property{} = property} = Properties.update_property(property, attrs)
      assert property.amenities == [amenity]
    end

    test "updates when removing amenities" do
      amenity = amenity_fixture()
      property = property_fixture(%{"amenities" => [amenity.id]})
      attrs = Map.put(@update_attrs, "amenities", [])

      assert {:ok, %Property{} = property} = Properties.update_property(property, attrs)
      assert property.amenities == []
    end

    test "keeps the same slug" do
      property = property_fixture()

      assert {:ok, %Property{} = property} = Properties.update_property(property, @update_attrs)

      assert %Property{
               slug: "apartamento-rua-carlos-barbosa-1650-vila-industrial-toledo-pr"
             } = property
    end

    test "with invalid data returns error changeset" do
      property = property_fixture()

      assert {:error, %Ecto.Changeset{}} = Properties.update_property(property, @invalid_attrs)
      assert property == Properties.get_property!(property.id)
    end
  end

  describe "get_property_by!/1" do
    test "returns a single property" do
      property = property_fixture()

      assert Properties.get_property_by!(slug: property.slug) == property
    end
  end

  describe "get_property!/1" do
    test "returns a single property" do
      property = property_fixture()

      assert Properties.get_property!(property.id) == property
    end
  end

  describe "list_cities/0" do
    test "returns all cities" do
      property_fixture(%{"city" => "Umuarama"})
      property_fixture(%{"city" => "Toledo"})

      assert ["Toledo", "Umuarama"] = Properties.list_cities()
    end
  end

  describe "list_neighborhoods/0" do
    test "returns all neighborhoods" do
      property_fixture(%{"neighborhood" => "Sumarezinho"})
      property_fixture(%{"neighborhood" => "Paraíso"})

      assert ["Paraíso", "Sumarezinho"] = Properties.list_neighborhoods()
    end
  end

  describe "list_properties/0" do
    test "returns all properties" do
      property = property_fixture()
      _deleted_property = property_fixture(%{"complement" => "AP 1", "deleted_at" => NaiveDateTime.utc_now()})

      assert Properties.list_properties() == [property]
    end
  end

  describe "list_properties/1" do
    test "returns all properties of given search" do
      property = property_fixture(%{"address" => "Rua Harmonia"})
      _other_property = property_fixture(%{"address" => "Rua do Paraíso"})

      assert Properties.list_properties(%{"q" => "rua harmonia"}) == [property]
    end

    test "returns all properties of given city" do
      property = property_fixture(%{"city" => "Umuarama"})
      _other_property = property_fixture(%{"city" => "Toledo"})

      assert Properties.list_properties(%{"city" => "Umuarama"}) == [property]
    end

    test "returns all properties of given neighborhood" do
      property = property_fixture(%{"neighborhood" => "Jardim dos Príncipes"})
      _other_property = property_fixture(%{"neighborhood" => "Zona 2"})

      assert Properties.list_properties(%{"neighborhood" => "Jardim dos Príncipes"}) == [property]
    end

    test "returns all properties of given area" do
      property = property_fixture(%{"area" => "66"})
      _other_property = property_fixture(%{"area" => "68", "complement" => "AP 4"})

      assert Properties.list_properties(%{"min_area" => "65", "max_area" => "67"}) == [property]
    end

    test "returns all properties of given quantity of bathrooms" do
      property = property_fixture(%{"qty_bathrooms" => "2"})
      _other_property = property_fixture(%{"qty_bathrooms" => "1", "complement" => "AP 2"})

      assert Properties.list_properties(%{"qty_bathrooms" => "2"}) == [property]
    end

    test "returns all properties of given quantity of rooms" do
      property = property_fixture(%{"qty_rooms" => "3"})
      _other_property = property_fixture(%{"qty_rooms" => "2", "complement" => "AP 3"})

      assert Properties.list_properties(%{"qty_rooms" => "3"}) == [property]
    end

    test "returns all properties of given type" do
      property = property_fixture(%{"type" => "lot"})
      _other_property = property_fixture(%{"type" => "house"})

      assert Properties.list_properties(%{"type" => "lot"}) == [property]
    end

    test "returns all properties of given amount of params" do
      property = property_fixture()

      assert Properties.list_properties(%{
               "min_area" => "45",
               "city" => "Toledo",
               "neighborhood" => "Vila Industrial",
               "qty_rooms" => "3",
               "type" => "apartment"
             }) == [property]
    end
  end

  describe "list_properties/2" do
    test "returns all properties of given search" do
      _first_property = property_fixture(%{"complement" => "AP 1"})
      second_property = property_fixture(%{"complement" => "AP 2"})
      third_property = property_fixture(%{"complement" => "AP 3"})

      assert Properties.list_properties(%{}, 2) == [third_property, second_property]
    end
  end

  test "soft_delete_property/1 deletes the property" do
    property = property_fixture()

    assert {:ok, %Property{}} = Properties.soft_delete_property(property)
    refute Properties.get_property!(property.id).deleted_at == nil
  end

  describe "load_amenities/1" do
    test "loads the amenities of property" do
      property = property_fixture()

      assert Properties.load_amenities(property) == Repo.preload(property, :amenities)
    end
  end

  describe "load_images/1" do
    test "loads the images of property" do
      property = property_fixture()

      assert Properties.load_images(property) == Repo.preload(property, :images)
    end
  end

  describe "translate_type/1" do
    test "translates the type" do
      assert Properties.translate_type(:apartment) == "Apartamento"
      assert Properties.translate_type(:house) == "Casa"
      assert Properties.translate_type(:lot) == "Lote"
    end
  end
end
