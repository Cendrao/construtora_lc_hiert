defmodule ConstrutoraLcHiertWeb.ContactController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.Mailer
  alias ConstrutoraLcHiertWeb.Email

  def create(conn, %{"email" => email, "name" => name, "message" => message}) do
    email
    |> Email.contact_message(name, message)
    |> Mailer.deliver_now()

    json(conn, %{data: gettext("Message successfully sent")})
  rescue
    _ ->
      conn
      |> put_status(500)
      |> json(%{data: gettext("The message was not sent")})
  end
end
