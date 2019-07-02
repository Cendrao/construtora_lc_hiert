defmodule ConstrutoraLcHiertWeb.AboutController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.RealEstate.Properties

  def index(conn, _params) do
    footer_properties = Properties.list_properties(%{}, 3)

    render(conn, "index.html", footer_properties: footer_properties)
  end
end
