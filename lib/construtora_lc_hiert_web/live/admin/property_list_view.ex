defmodule ConstrutoraLcHiertWeb.Live.Admin.PropertyListView do
  use Phoenix.LiveView

  alias ConstrutoraLcHiertWeb.Admin.PropertyView
  alias ConstrutoraLcHiert.RealEstate.Properties

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

  def handle_event("filter_types", value, socket) do
    build_filters(socket, :type, value)
  end

  def handle_event("filter_neighborhoods", value, socket) do
    build_filters(socket, :neighborhood, value)
  end

  def handle_event("filter_cities", value, socket) do
    build_filters(socket, :city, value)
  end

  def handle_event("remove_filters", _value, socket) do
    build_filters(socket)
  end

  defp build_filters(socket, key, value) do
    active_filters = socket.assigns.filters

    new_filters =
      if value == Map.get(active_filters, key) do
        Map.delete(active_filters, key)
      else
        Map.put(active_filters, key, value)
      end

    {:noreply, fetch(socket, new_filters)}
  end

  defp build_filters(socket) do
    {:noreply, fetch(socket, %{})}
  end

  defp fetch(socket, filters) do
    properties = Properties.list_properties(filters)

    assign(socket, properties: properties, filters: filters)
  end
end
