defmodule ConstrutoraLcHiertWeb.LayoutView do
  use ConstrutoraLcHiertWeb, :view

  alias ConstrutoraLcHiertWeb.PageTitle
  alias ConstrutoraLcHiertWeb.OpenGraph

  def page_title(conn) do
    view = view_module(conn)
    action = action_name(conn)
    PageTitle.for({view, action, conn.assigns})
  end

  def open_graph(conn) do
    view = view_module(conn)
    action = action_name(conn)
    OpenGraph.for({view, action, conn})
  end

  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end

  def active_class(conn, path) do
    current_path = Path.join(["/" | conn.path_info])

    if path == current_path do
      "active"
    else
      nil
    end
  end
end
