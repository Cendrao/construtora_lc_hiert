defmodule ConstrutoraLcHiertWeb.SubscriberController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.Subscribers
  alias ConstrutoraLcHiert.Subscribers.ErrorHandler

  def create(conn, params) do
    params
    |> Subscribers.create_subscriber()
    |> reply(conn)
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
