defmodule ConstrutoraLcHiert.RealEstate.Filters do
  @moduledoc """
  Filters to apply in a list of properties
  """

  import Ecto.Query

  def apply(query, params) do
    Enum.reduce(params, query, fn {key, value}, query -> filter_by(query, key, value) end)
  end

  defp filter_by(query, _, nil), do: query

  defp filter_by(query, :q, param) do
    query
    |> where([p], ilike(p.address, ^"%#{param}%"))
    |> or_where([p], ilike(p.city, ^"%#{param}%"))
    |> or_where([p], ilike(p.complement, ^"%#{param}%"))
    |> or_where([p], ilike(p.description, ^"%#{param}%"))
    |> or_where([p], ilike(p.neighborhood, ^"%#{param}%"))
  end

  defp filter_by(query, :city, param) do
    where(query, [p], ilike(p.city, ^"%#{param}%"))
  end

  defp filter_by(query, :neighborhood, param) do
    where(query, [p], ilike(p.neighborhood, ^"%#{param}%"))
  end

  defp filter_by(query, :min_area, param) do
    where(query, [p], p.area >= ^param)
  end

  defp filter_by(query, :max_area, param) do
    where(query, [p], p.area <= ^param)
  end

  defp filter_by(query, :type, param) do
    where(query, [p], p.type == ^param)
  end

  defp filter_by(query, :qty_bathrooms, param) do
    where(query, [p], p.qty_bathrooms == ^param)
  end

  defp filter_by(query, :qty_rooms, param) do
    where(query, [p], p.qty_rooms == ^param)
  end

  defp filter_by(query, _, _), do: query
end
