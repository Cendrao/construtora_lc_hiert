defmodule ConstrutoraLcHiert.Authentication.ErrorHandler do
  import Plug.Conn

  use Phoenix.Controller

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, _reason}, _opts) do
    conn
    |> put_flash(:error, get_message(type))
    |> redirect(to: "/login")
  end

  def get_message(:unauthenticated), do: translate("Unauthenticated")
  def get_message(:not_found), do: translate("User not found")
  def get_message(:invalid_credentials), do: translate("Invalid credentials")
  def get_message(_), do: translate("An error occurred")

  defp translate(message) do
    Gettext.dgettext(ConstrutoraLcHiertWeb.Gettext, "authentication", message)
  end
end
