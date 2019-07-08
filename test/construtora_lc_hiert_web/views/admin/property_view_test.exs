defmodule ConstrutoraLcHiertWeb.Admin.PropertyViewTest do
  use ConstrutoraLcHiertWeb.ConnCase, async: true

  alias ConstrutoraLcHiertWeb.Admin.PropertyView

  describe "filter_button_class/3" do
    test "display the default button class" do
      filters = %{city: "Umuarama"}
      button_key = "city"
      button_value = "São Paulo"

      assert PropertyView.filter_button_class(filters, button_key, button_value) == "btn-default"
    end

    test "display the active button class" do
      filters = %{city: "Umuarama"}
      button_key = "city"
      button_value = "Umuarama"

      assert PropertyView.filter_button_class(filters, button_key, button_value) == "btn-success"
    end
  end
end
