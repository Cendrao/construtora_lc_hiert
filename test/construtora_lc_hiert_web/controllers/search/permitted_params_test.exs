defmodule ConstrutoraLcHiertWeb.SearchController.PermittedParamsTest do
  use ConstrutoraLcHiertWeb.ConnCase

  alias ConstrutoraLcHiertWeb.SearchController.PermittedParams

  describe "new/1" do
    test "returns the params permitted for searching" do
      params = %{
        "type" => "apartment",
        "q" => "rua harmonia",
        "page" => "3",
        "hacker" => "aqui"
      }

      assert PermittedParams.new(params) == %{
               q: "rua harmonia",
               city: nil,
               neighborhood: nil,
               max_area: nil,
               min_area: nil,
               type: "apartment",
               qty_bathrooms: nil,
               qty_rooms: nil,
               page: "3"
             }
    end
  end
end
