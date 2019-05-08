defmodule ConstrutoraLcHiertWeb.PropertyController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.Properties

  def show(conn, %{"slug" => slug}) do
    property = Properties.get_property_by!(slug: slug)
    footer_properties = Properties.list_properties(%{}, 3)
    featured_properties = Enum.take(footer_properties, 2)
    cities = Properties.list_cities()
    neighborhoods = Properties.list_neighborhoods()

    render(conn, "show.html",
      property: property,
      featured_properties: featured_properties,
      footer_properties: footer_properties,
      cities: cities,
      neighborhoods: neighborhoods
    )
  end
end
