defmodule ConstrutoraLcHiertWeb.Admin.PageController do
  use ConstrutoraLcHiertWeb, :controller

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "index.html", current_user: user)
  end
end
