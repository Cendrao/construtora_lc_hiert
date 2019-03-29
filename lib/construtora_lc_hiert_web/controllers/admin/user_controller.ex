defmodule ConstrutoraLcHiertWeb.Admin.UserController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.Accounts

  def index(conn, _params) do
    users = Accounts.list_users()

    render(conn, "index.html", %{users: users})
  end
end
