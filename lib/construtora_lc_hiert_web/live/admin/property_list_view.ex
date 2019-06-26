defmodule ConstrutoraLcHiertWeb.Live.Admin.PropertyListView do
  use Phoenix.LiveView

  alias ConstrutoraLcHiertWeb.Admin.PropertyView
  alias ConstrutoraLcHiert.Properties

  def render(assigns), do: PropertyView.render("index.html", assigns)

  def mount(_session, socket) do
    cities = Properties.list_cities()
    neighborhoods = Properties.list_neighborhoods()
    properties = Properties.list_properties()

    {:ok,
     assign(socket,
       cities: cities,
       neighborhoods: neighborhoods,
       properties: properties,
       filters: %{}
     )}
  end

  def handle_event("filter_type", value, socket) do
    filter = %{"type" => value}

    {:noreply, fetch(socket, filter)}
  end

  def handle_event("filter_neighborhoods", value, socket) do
    filter = %{"neighborhood" => value}

    {:noreply, fetch(socket, filter)}
  end

  def handle_event("filter_cities", value, socket) do
    filter = %{"city" => value}

    {:noreply, fetch(socket, filter)}
  end

  def handle_event("remove_filters", _value, socket) do
    {:noreply, fetch(socket)}
  end

  defp fetch(socket, filter) do
    filters = apply_filters(socket.assigns.filters, filter)
    properties = Properties.list_properties(filters)

    assign(socket, properties: properties, filters: filters)
  end

  defp fetch(socket) do
    properties = Properties.list_properties()

    assign(socket, properties: properties, filters: %{})
  end

  defp apply_filters(selected_filters, filter) do
    key = filter |> Map.keys() |> List.first()

    new_filter_value = Map.get(filter, key)
    selected_filter_value = Map.get(selected_filters, key)

    if new_filter_value == selected_filter_value do
      Map.delete(selected_filters, key)
    else
      Map.merge(selected_filters, filter)
    end
  end
end
