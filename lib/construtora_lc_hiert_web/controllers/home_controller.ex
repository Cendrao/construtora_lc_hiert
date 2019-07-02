defmodule ConstrutoraLcHiertWeb.HomeController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.RealEstate.Properties

  def index(conn, _params) do
    featured_properties = Properties.list_properties(%{}, 6)
    footer_properties = Enum.take(featured_properties, 3)
    cities = Properties.list_cities()
    neighborhoods = Properties.list_neighborhoods()

    render(conn, "index.html",
      featured_properties: featured_properties,
      footer_properties: footer_properties,
      cities: cities,
      neighborhoods: neighborhoods
    )
  end
end
