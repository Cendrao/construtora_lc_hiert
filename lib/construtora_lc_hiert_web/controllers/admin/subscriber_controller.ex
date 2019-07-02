defmodule ConstrutoraLcHiertWeb.Admin.SubscriberController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.Customer.Subscribers

  def index(conn, _params) do
    subscribers = Subscribers.list_subscribers()

    render(conn, "index.html", %{subscribers: subscribers})
  end
end
