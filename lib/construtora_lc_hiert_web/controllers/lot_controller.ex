defmodule ConstrutoraLcHiertWeb.LotController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.Properties

  def index(conn, _params) do
    properties = Properties.list_properties(:lot)

    conn
    |> put_view(ConstrutoraLcHiertWeb.PropertyView)
    |> render("index.html", properties: properties)
  end
end
