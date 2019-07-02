defmodule ConstrutoraLcHiertWeb.Helpers.CheckboxHelperTest do
  use ConstrutoraLcHiertWeb.ConnCase, async: true

  alias ConstrutoraLcHiert.RealEstate.Properties
  alias ConstrutoraLcHiert.RealEstate.Properties.Property
  alias ConstrutoraLcHiertWeb.Helpers.CheckboxHelper

  test "multiselect_checkboxes/4" do
    changeset = %Property{} |> Properties.load_amenities() |> Properties.change_property()

    form = Phoenix.HTML.FormData.to_form(changeset, [])

    [first_checkbox | _] =
      CheckboxHelper.multiselect_checkboxes(
        form,
        :amenities,
        [{"Piscina", 1}, {"Ar condicionado", 2}]
      )

    html = Phoenix.HTML.safe_to_string(first_checkbox)

    assert html =~
             "<label class=\"checkbox-inline\">" <>
               "<input id=\"property_amenities_1\" name=\"property[amenities][]\" type=\"checkbox\" value=\"1\">" <>
               "Piscina" <>
               "</label>"
  end
end
