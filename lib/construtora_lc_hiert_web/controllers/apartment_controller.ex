defmodule ConstrutoraLcHiertWeb.ApartmentController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.Properties

  def index(conn, _params) do
    properties = Properties.list_properties(:apartment)
    footer_properties = Enum.take(properties, 3)

    conn
    |> put_view(ConstrutoraLcHiertWeb.PropertyView)
    |> render("index.html", properties: properties, footer_properties: footer_properties)
  end
end
