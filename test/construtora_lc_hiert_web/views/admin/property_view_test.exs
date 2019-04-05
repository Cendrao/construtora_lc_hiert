defmodule ConstrutoraLcHiertWeb.Admin.PropertyViewTest do
  use ConstrutoraLcHiertWeb.ConnCase, async: true

  alias ConstrutoraLcHiertWeb.Admin.PropertyView

  test "property_types_for_select/0" do
    assert PropertyView.property_types_for_select() == [
             {"Apartamento", :apartment},
             {"Casa", :house},
             {"Lote", :lot}
           ]
  end

  test "translate_type/1" do
    assert PropertyView.translate_type(:apartment) == "Apartamento"
    assert PropertyView.translate_type(:house) == "Casa"
    assert PropertyView.translate_type(:lot) == "Lote"
  end
end
