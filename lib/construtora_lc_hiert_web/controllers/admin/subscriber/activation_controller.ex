defmodule ConstrutoraLcHiertWeb.Admin.Subscriber.ActivationController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.Customer.Subscribers

  def create(conn, %{"subscriber_id" => id}) do
    subscriber = Subscribers.get_subscriber!(id)

    {:ok, _} = Subscribers.activate_subscriber(subscriber)

    conn
    |> put_flash(:info, gettext("Successfully activated"))
    |> redirect(to: Routes.admin_subscriber_path(conn, :index))
  end

  def delete(conn, %{"subscriber_id" => id}) do
    subscriber = Subscribers.get_subscriber!(id)

    {:ok, _} = Subscribers.deactivate_subscriber(subscriber)

    conn
    |> put_flash(:info, gettext("Successfully deactivated"))
    |> redirect(to: Routes.admin_subscriber_path(conn, :index))
  end
end
