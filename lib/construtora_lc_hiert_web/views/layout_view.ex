defmodule ConstrutoraLcHiertWeb.LayoutView do
  use ConstrutoraLcHiertWeb, :view

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
