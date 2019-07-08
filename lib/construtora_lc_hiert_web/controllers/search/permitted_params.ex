defmodule ConstrutoraLcHiertWeb.SearchController.PermittedParams do
  @moduledoc """
  The permitted params for properties searching.
  """

  defstruct [
    :q,
    :city,
    :neighborhood,
    :min_area,
    :max_area,
    :type,
    :qty_bathrooms,
    :qty_rooms,
    :page
  ]

  def new(params) do
    %{
      q: params["q"],
      city: params["city"],
      neighborhood: params["neighborhood"],
      min_area: params["min_area"],
      max_area: params["max_area"],
      type: params["type"],
      qty_bathrooms: params["qty_bathrooms"],
      qty_rooms: params["qty_rooms"],
      page: params["page"]
    }
  end
end
