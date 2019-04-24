defmodule ConstrutoraLcHiertWeb.ApartmentController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.Properties

  def index(conn, _params) do
    apartments = Properties.list_properties(:apartment)

    render(conn, "index.html", apartments: apartments)
  end
end
