defmodule ConstrutoraLcHiertWeb.UnsubscribeController do
  use ConstrutoraLcHiertWeb, :controller

  plug :put_layout, false

  alias ConstrutoraLcHiert.Customer.Subscribers

  def index(conn, %{"id" => uuid}) do
    subscriber = Subscribers.get_subscriber_by!(uuid: uuid)

    render(conn, "index.html", subscriber: subscriber)
  end

  def delete(conn, %{"id" => uuid}) do
    subscriber = Subscribers.get_subscriber_by!(uuid: uuid)

    {:ok, _} = Subscribers.deactivate_subscriber(subscriber)

    render(conn, "delete.html")
  end
end
