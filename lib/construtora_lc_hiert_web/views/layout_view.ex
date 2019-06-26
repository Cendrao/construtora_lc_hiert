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

  @doc """
  Generates path for the JavaScript view we want to use in this combination of
  controller/action.
  """
  def js_view_path(conn) do
    [controller_name(conn), action_name(conn)]
    |> Enum.join("/")
  end

  defp controller_name(conn) do
    conn
    |> Phoenix.Controller.controller_module()
    |> to_string
    |> String.split(".")
    |> List.delete_at(0)
    |> List.delete_at(0)
    |> Enum.join("/")
    |> String.replace("Controller", "")
    |> String.downcase()
  end
end
