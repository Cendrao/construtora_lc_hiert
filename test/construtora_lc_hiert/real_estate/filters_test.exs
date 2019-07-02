defmodule ConstrutoraLcHiert.RealEstate.FiltersTest do
  use ConstrutoraLcHiert.DataCase
  use ConstrutoraLcHiert.Fixtures, [:property]

  alias ConstrutoraLcHiert.RealEstate.Properties.Property
  alias ConstrutoraLcHiert.RealEstate.Filters

  test "filter results by query" do
    _first_property = property_fixture(%{"address" => "Rua Carlos Barbosa"})
    second_property = property_fixture(%{"address" => "Rua Harmonia"})

    filtered_properties =
      Property
      |> preload([:amenities, :images])
      |> Filters.apply(%{"q" => "rua harmonia"})
      |> Repo.all()

    assert filtered_properties == [second_property]
  end

  test "filter results by city" do
    _first_property = property_fixture(%{"city" => "São Paulo"})
    second_property = property_fixture(%{"city" => "Umuarama"})

    filtered_properties =
      Property
      |> preload([:amenities, :images])
      |> Filters.apply(%{"city" => "umuarama"})
      |> Repo.all()

    assert filtered_properties == [second_property]
  end

  test "filter results by neighborhood" do
    _first_property = property_fixture(%{"neighborhood" => "Sumarezinho"})
    second_property = property_fixture(%{"neighborhood" => "Vila Madalena"})

    filtered_properties =
      Property
      |> preload([:amenities, :images])
      |> Filters.apply(%{"neighborhood" => "madalena"})
      |> Repo.all()

    assert filtered_properties == [second_property]
  end

  test "filter results by min_area" do
    _first_property = property_fixture(%{"area" => "50", "city" => "Toledo"})
    second_property = property_fixture(%{"area" => "60", "city" => "Umuarama"})

    filtered_properties =
      Property
      |> preload([:amenities, :images])
      |> Filters.apply(%{"min_area" => "55"})
      |> Repo.all()

    assert filtered_properties == [second_property]
  end

  test "filter results by max_area" do
    first_property = property_fixture(%{"area" => "50", "city" => "Toledo"})
    _second_property = property_fixture(%{"area" => "60", "city" => "Umuarama"})

    filtered_properties =
      Property
      |> preload([:amenities, :images])
      |> Filters.apply(%{"max_area" => "55"})
      |> Repo.all()

    assert filtered_properties == [first_property]
  end

  test "filter results by type" do
    _first_property = property_fixture(%{"type" => :apartment})
    second_property = property_fixture(%{"type" => :house})

    filtered_properties =
      Property
      |> preload([:amenities, :images])
      |> Filters.apply(%{"type" => "house"})
      |> Repo.all()

    assert filtered_properties == [second_property]
  end

  test "filter results by qty_bathrooms" do
    _first_property = property_fixture(%{"qty_bathrooms" => "1", "city" => "Toledo"})
    second_property = property_fixture(%{"qty_bathrooms" => "2", "city" => "Umuarama"})

    filtered_properties =
      Property
      |> preload([:amenities, :images])
      |> Filters.apply(%{"qty_bathrooms" => "2"})
      |> Repo.all()

    assert filtered_properties == [second_property]
  end

  test "filter results by qty_rooms" do
    _first_property = property_fixture(%{"qty_rooms" => "1", "city" => "Toledo"})
    second_property = property_fixture(%{"qty_rooms" => "2", "city" => "Umuarama"})

    filtered_properties =
      Property
      |> preload([:amenities, :images])
      |> Filters.apply(%{"qty_rooms" => "2"})
      |> Repo.all()

    assert filtered_properties == [second_property]
  end
end
