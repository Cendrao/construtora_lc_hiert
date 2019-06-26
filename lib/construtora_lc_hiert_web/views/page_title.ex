defmodule ConstrutoraLcHiertWeb.PageTitle do
  use ConstrutoraLcHiertWeb, :view

  alias ConstrutoraLcHiertWeb.PropertyView
  alias ConstrutoraLcHiertWeb.ContactView

  @app_name "Construtora LC Hiert"

  def for({view, action, assigns}) do
    {view, action, assigns}
    |> build_title()
    |> append_app_name()
  end

  defp build_title({PropertyView, :index, _}) do
    "Imóveis à venda"
  end

  defp build_title({PropertyView, :show, %{property: property}}) do
    PropertyView.translate_type(property.type) <>
      " - " <>
      property.neighborhood <>
      " - " <>
      PropertyView.city(property)
  end

  defp build_title({ContactView, :index, _}) do
    "Entre em contato"
  end

  defp build_title(_), do: nil

  defp append_app_name(nil), do: @app_name
  defp append_app_name(title), do: "#{title} | #{@app_name}"
end
