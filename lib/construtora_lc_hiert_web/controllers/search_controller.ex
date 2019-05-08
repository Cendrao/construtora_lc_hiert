defmodule ConstrutoraLcHiertWeb.SearchController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.Properties

  def index(conn, params) do
    properties = Properties.list_properties(params)
    footer_properties = Properties.list_properties(%{}, 3)

    conn
    |> put_view(ConstrutoraLcHiertWeb.PropertyView)
    |> render("index.html", properties: properties, footer_properties: footer_properties)
  end
end
