defmodule ConstrutoraLcHiertWeb.Email do
  @moduledoc """
  Provides all the emails available in the app.

  ## Examples

      "maico@biridin.com"
        |> Email.contact_message(name: "Jesus", message: "Estou na goiabeira")
        |> Email.deliver_now()

  """

  use Bamboo.Phoenix, view: ConstrutoraLcHiertWeb.EmailView

  alias ConstrutoraLcHiert.Mailer

  @app_name "Construtora LC Hiert"
  @app_email "construcao.lc@gmail.com"

  def deliver_now(email) do
    Mailer.deliver_now(email)
  end

  def contact_message(email, name: name, message: message) do
    base_email()
    |> from(email)
    |> put_header("Reply-To", email)
    |> to(@app_email)
    |> subject("Contato via site")
    |> assign(:name, name)
    |> assign(:message, message)
    |> render(:contact_message)
  end

  def subscriber_message(email, property: property) do
    base_email()
    |> from(@app_email)
    |> put_header("Reply-To", @app_email)
    |> to(email)
    |> subject("Novo imóvel @ #{@app_name}")
    |> assign(:property, property)
    |> render(:subscriber_message)
  end

  defp base_email do
    new_email()
    |> put_html_layout({ConstrutoraLcHiertWeb.LayoutView, "email.html"})
  end
end
