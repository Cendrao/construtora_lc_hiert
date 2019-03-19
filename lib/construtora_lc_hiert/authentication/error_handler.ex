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

  def get_message(:unauthenticated), do: "Não autenticado! Faça login."
  def get_message(:not_found), do: "Usuário não encontrado."
  def get_message(:invalid_credentials), do: "A senha está incorreta."
  def get_message(_), do: "Ocorreu um erro! Tente novamente."
end
