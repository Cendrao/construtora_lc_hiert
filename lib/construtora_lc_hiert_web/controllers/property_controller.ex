defmodule ConstrutoraLcHiertWeb.PropertyController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.Properties

  def show(conn, %{"slug" => slug}) do
    apartment = Properties.get_property_by!(slug: slug)
    featured_properties = Properties.list_featured_properties(2)

    render(conn, "show.html", apartment: apartment, featured_properties: featured_properties)
  end
end
