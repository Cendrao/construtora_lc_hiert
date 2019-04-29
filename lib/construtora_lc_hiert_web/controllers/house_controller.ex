defmodule ConstrutoraLcHiertWeb.HouseController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.Properties

  def index(conn, _params) do
    properties = Properties.list_properties(:house)

    conn
    |> put_view(ConstrutoraLcHiertWeb.PropertyView)
    |> render("index.html", properties: properties)
  end
end
