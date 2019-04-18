defmodule ConstrutoraLcHiert.AmenitiesTest do
  use ConstrutoraLcHiert.DataCase

  alias ConstrutoraLcHiert.Amenities
  alias ConstrutoraLcHiert.Amenities.Amenity

  @valid_attrs %{name: "Piscina"}
  @invalid_attrs %{name: nil}

  def amenity_fixture(attrs \\ %{}) do
    {:ok, amenity} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Amenities.create_amenity()

    amenity
  end

  describe "create_amenity/1" do
    test "with valid data creates a amenity" do
      assert {:ok, %Amenity{} = amenity} = Amenities.create_amenity(@valid_attrs)

      assert %Amenity{name: "Piscina"} = amenity
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{} = changeset} = Amenities.create_amenity(@invalid_attrs)

      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end
  end

  describe "list_amenities/0" do
    test "returns all amenities" do
      amenity = amenity_fixture()
      assert Amenities.list_amenities() == [amenity]
    end
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
