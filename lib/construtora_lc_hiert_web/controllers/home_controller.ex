defmodule ConstrutoraLcHiertWeb.HomeController do
  use ConstrutoraLcHiertWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end