defmodule ConstrutoraLcHiertWeb.Admin.PropertyView do
  use ConstrutoraLcHiertWeb, :view

  def filter_button_class(filters, key, value) do
    if Map.get(filters, key) == value do
      "btn-success"
    else
      "btn-default"
    end
  end
end
