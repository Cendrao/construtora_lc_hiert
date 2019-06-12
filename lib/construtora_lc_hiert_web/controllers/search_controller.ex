defmodule ConstrutoraLcHiertWeb.SearchController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.Properties

  def index(conn, params) do
    paged_properties = Properties.list_paged_properties(params)
    footer_properties = Properties.list_properties(%{}, 3)

    conn
    |> put_view(ConstrutoraLcHiertWeb.PropertyView)
    |> render("index.html",
      paged_properties: paged_properties,
      footer_properties: footer_properties
    )
  end
end
