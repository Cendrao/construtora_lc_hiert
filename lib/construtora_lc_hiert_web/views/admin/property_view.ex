defmodule ConstrutoraLcHiertWeb.Admin.PropertyView do
  use ConstrutoraLcHiertWeb, :view

  def filter_button_class(filters, key, value) when is_binary(key) do
    filter_button_class(filters, String.to_atom(key), value)
  end

  def filter_button_class(filters, key, value) do
    if Map.get(filters, key) == value do
      "btn-success"
    else
      "btn-default"
    end
  end
end
