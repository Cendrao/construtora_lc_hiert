defmodule ConstrutoraLcHiert.Authentication.ErrorHandler do
  import Plug.Conn

  use Phoenix.Controller

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, _reason}, _opts) do
    body = to_string(type)

    conn
    |> put_flash(:error, body)
    |> redirect(to: "/login")
  end
end
