defmodule ConstrutoraLcHiertWeb.ContactController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.Mailer
  alias ConstrutoraLcHiertWeb.Email
  alias ConstrutoraLcHiert.Properties

  def index(conn, _params) do
    footer_properties = Properties.list_properties(%{}, 3)

    render(conn, "index.html", footer_properties: footer_properties)
  end

  def create(conn, %{"email" => email, "name" => name, "message" => message}) do
    email
    |> Email.contact_message(name, message)
    |> Mailer.deliver_now()

    json(conn, %{data: gettext("Message successfully sent")})
  rescue
    exception ->
      Sentry.capture_exception(exception, stacktrace: System.stacktrace())

      conn
      |> put_status(500)
      |> json(%{data: gettext("The message was not sent")})
  end
end
