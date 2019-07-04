defmodule ConstrutoraLcHiertWeb.SubscriberController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.Customer.Subscribers
  alias ConstrutoraLcHiert.Customer.Subscribers.ErrorHandler

  def create(conn, params) do
    subscriber = Subscribers.get_subscriber_by_email(params["email"])

    case subscriber do
      nil ->
        params |> Subscribers.create_subscriber() |> reply(conn)

      _ ->
        subscriber |> Subscribers.activate_subscriber() |> reply(conn)
    end
  end

  defp reply({:ok, _}, conn) do
    json(conn, %{data: gettext("Successfully created")})
  end

  defp reply({:error, reason}, conn) do
    error_message = reason |> Map.get(:errors) |> ErrorHandler.get_message()

    conn
    |> put_status(500)
    |> json(%{data: "Oops! #{error_message}"})
  end
end
