defmodule ConstrutoraLcHiertWeb.Helpers.PaginatorHelperTest do
  use ConstrutoraLcHiertWeb.ConnCase, async: true

  import Phoenix.HTML, only: [safe_to_string: 1]

  alias ConstrutoraLcHiert.RealEstate.Properties
  alias ConstrutoraLcHiertWeb.Helpers.PaginatorHelper

  describe "render/3" do
    test "renders the paginator" do
      paginated_results = Properties.list_paged_properties(%{"page" => 1})

      paginator =
        ConstrutoraLcHiertWeb.Endpoint
        |> PaginatorHelper.render(paginated_results, class: "paginator")
        |> safe_to_string()

      assert paginator ==
               "<ul class=\"paginator\">" <>
                 "<li disabled>" <>
                 "<a href=\"?page=0\">" <>
                 "<svg class=\" icon\"><use xlink:href=\"/images/icons.svg#left-arrow\"></svg>" <>
                 "</a>" <>
                 "</li>" <>
                 "<li class=\"active\" disabled>" <>
                 "<a href=\"?page=1\">1</a>" <>
                 "</li>" <>
                 "<li disabled>" <>
                 "<a href=\"?page=2\">" <>
                 "<svg class=\" icon\"><use xlink:href=\"/images/icons.svg#right-arrow\"></svg>" <>
                 "</a>" <>
                 "</li>" <>
                 "</ul>"
    end
  end
end
