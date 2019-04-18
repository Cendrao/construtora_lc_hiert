defmodule ConstrutoraLcHiertWeb.Helpers.CheckboxHelperTest do
  use ConstrutoraLcHiertWeb.ConnCase, async: true

  alias ConstrutoraLcHiert.Properties
  alias ConstrutoraLcHiert.Properties.Property
  alias ConstrutoraLcHiertWeb.Helpers.CheckboxHelper

  test "multiselect_checkboxes/4" do
    changeset = Properties.change_property(%Property{})

    form = Phoenix.HTML.FormData.to_form(changeset, [])

    [first_checkbox | _] =
      CheckboxHelper.multiselect_checkboxes(
        form,
        :amenities,
        [{"Piscina", 1}, {"Ar condicionado", 2}]
      )

    html = Phoenix.HTML.safe_to_string(first_checkbox)

    assert html =~
             "<div class=\"checkbox\">" <>
               "<label>" <>
               "<input id=\"property_amenities_1\" name=\"property[amenities][]\" type=\"checkbox\" value=\"1\">" <>
               "Piscina" <>
               "</label>" <>
               "</div>"
  end
end
