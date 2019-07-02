defmodule ConstrutoraLcHiertWeb.ApartmentController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.RealEstate.Properties

  def index(conn, params) do
    params = %{"type" => :apartment, "page" => params["page"]}
    paged_properties = Properties.list_paged_properties(params)
    footer_properties = Enum.take(paged_properties.list, 3)

    conn
    |> put_view(ConstrutoraLcHiertWeb.PropertyView)
    |> render("index.html",
      paged_properties: paged_properties,
      footer_properties: footer_properties
    )
  end
end
