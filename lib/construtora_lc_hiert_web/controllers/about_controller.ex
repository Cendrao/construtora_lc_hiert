defmodule ConstrutoraLcHiertWeb.AboutController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.Properties

  def index(conn, _params) do
    footer_properties = Properties.list_featured_properties(3)

    render(conn, "index.html", footer_properties: footer_properties)
  end
end
