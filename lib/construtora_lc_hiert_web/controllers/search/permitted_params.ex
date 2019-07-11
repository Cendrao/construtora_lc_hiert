defmodule ConstrutoraLcHiertWeb.SearchController.PermittedParams do
  @moduledoc """
  The permitted params for properties searching.
  """

  @types %{
    q: :string,
    city: :string,
    neighborhood: :string,
    min_area: :integer,
    max_area: :integer,
    type: :string,
    qty_bathrooms: :integer,
    qty_rooms: :integer,
    page: :integer
  }

  @fields Map.keys(@types)

  @doc """
  Type casting for filters and pagination

  ## Examples

      iex> new(%{"city" => "Umuarama", "page" => "2"})
      %{city: "Umuarama", page: 2}

  """
  def new(params) when is_map(params) do
    {%{}, @types}
    |> Ecto.Changeset.cast(params, @fields)
    |> Ecto.Changeset.apply_changes()
  end
end
