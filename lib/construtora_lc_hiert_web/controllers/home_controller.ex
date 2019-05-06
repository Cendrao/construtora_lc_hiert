defmodule ConstrutoraLcHiertWeb.HomeController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.Properties

  def index(conn, _params) do
    featured_properties = Properties.list_featured_properties(6)
    footer_properties = Enum.take(featured_properties, 3)

    render(conn, "index.html",
      featured_properties: featured_properties,
      footer_properties: footer_properties
    )
  end
end
