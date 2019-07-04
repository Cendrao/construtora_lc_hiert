defmodule ConstrutoraLcHiertWeb.SitemapController do
  use ConstrutoraLcHiertWeb, :controller

  plug :put_layout, false

  alias ConstrutoraLcHiert.RealEstate.Properties

  def index(conn, _params) do
    properties = Properties.list_properties()

    conn
    |> put_resp_content_type("text/xml")
    |> render("index.html", properties: properties)
  end
end
