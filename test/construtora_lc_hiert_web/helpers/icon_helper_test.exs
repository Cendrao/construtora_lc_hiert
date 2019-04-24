defmodule ConstrutoraLcHiertWeb.Helpers.IconHelperTest do
  use ConstrutoraLcHiertWeb.ConnCase, async: true

  import Phoenix.HTML, only: [safe_to_string: 1]

  alias ConstrutoraLcHiertWeb.Helpers.IconHelper

  test "icon_tag/2 renders a svg icon" do
    image =
      ConstrutoraLcHiertWeb.Endpoint
      |> IconHelper.icon_tag("phone", class: "biridin")
      |> safe_to_string()

    assert image ==
             "<svg class=\"biridin icon\">" <>
               "<use xlink:href=\"/images/icons.svg#phone\">" <>
               "</svg>"
  end
end
