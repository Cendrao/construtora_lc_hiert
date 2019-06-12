defmodule ConstrutoraLcHiert.AmenitiesTest do
  use ConstrutoraLcHiert.DataCase
  use ConstrutoraLcHiert.Fixtures, [:amenity]

  alias ConstrutoraLcHiert.Amenities
  alias ConstrutoraLcHiert.Amenities.Amenity

  describe "create_amenity/1" do
    test "with valid data creates a amenity" do
      assert {:ok, %Amenity{} = amenity} = Amenities.create_amenity(@valid_amenity_attrs)

      assert %Amenity{name: "Piscina"} = amenity
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{} = changeset} =
               Amenities.create_amenity(@invalid_amenity_attrs)

      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end
  end

  describe "update_amenity/2" do
    test "with valid data updates the amenity" do
      amenity = amenity_fixture()

      assert {:ok, %Amenity{} = amenity} =
               Amenities.update_amenity(amenity, @update_amenity_attrs)

      assert amenity.name == "Ar condicionado"
    end

    test "with invalid data returns error changeset" do
      amenity = amenity_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Amenities.update_amenity(amenity, @invalid_amenity_attrs)

      assert amenity == Amenities.get_amenity!(amenity.id)
    end
  end

  test "get_amenity!/1 returns the amenity with given id" do
    amenity = amenity_fixture()

    assert Amenities.get_amenity!(amenity.id) == amenity
  end

  describe "list_amenities/0" do
    test "returns all amenities" do
      amenity = amenity_fixture()
      assert Amenities.list_amenities() == [amenity]
    end
  end

  test "hard_delete_amenity/1 deletes the amenity" do
    amenity = amenity_fixture()

    assert {:ok, %Amenity{}} = Amenities.hard_delete_amenity(amenity)
    assert_raise Ecto.NoResultsError, fn -> Amenities.get_amenity!(amenity.id) end
  end

  describe "get_amenities/1" do
    test "returns all amenities when given an array of amenity ids" do
      amenity = amenity_fixture()
      assert Amenities.get_amenities([amenity.id]) == [amenity]
    end

    test "returns empty array when given nil" do
      assert Amenities.get_amenities(nil) == []
    end
  end
end
