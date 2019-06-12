defmodule ConstrutoraLcHiert.PaginatorTest do
  use ConstrutoraLcHiert.DataCase
  use ConstrutoraLcHiert.Fixtures, [:property]

  alias ConstrutoraLcHiert.Properties.Property
  alias ConstrutoraLcHiert.Paginator

  describe "when the page is nil" do
    test "sets the page to the first page" do
      create_properties(1)

      paginator = Paginator.paginate(Property, nil)

      assert paginator.current_page == 1
    end
  end

  describe "when the page is a string" do
    test "sets the page to a integer" do
      create_properties(1)

      paginator = Paginator.paginate(Property, "1")

      assert paginator.current_page == 1
    end
  end

  test "paginate as 12 results per page" do
    create_properties(15)

    paginator_first_page = Paginator.paginate(Property, 1)
    assert length(paginator_first_page.list) == 12

    paginator_second_page = Paginator.paginate(Property, 2)
    assert length(paginator_second_page.list) == 3
  end

  test "prints pagination info" do
    properties = create_properties(10)

    paginator = Property |> preload([:images, :amenities]) |> Paginator.paginate(1)

    assert paginator == %{
             current_page: 1,
             results_per_page: 12,
             total_pages: 1,
             total_results: 10,
             list: properties
           }
  end

  defp create_properties(quantity) do
    for n <- 1..quantity do
      property_fixture(%{"address_number" => Integer.to_string(n)})
    end
  end
end
