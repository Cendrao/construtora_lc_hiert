defmodule ConstrutoraLcHiertWeb.Admin.UserController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.Account.Users.User
  alias ConstrutoraLcHiert.Account.Users

  def index(conn, _params) do
    users = Users.list_users()

    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    changeset = Users.change_user(user)

    render(conn, "show.html", user: user, changeset: changeset)
  end

  def new(conn, _params) do
    changeset = Users.change_user(%User{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => params}) do
    case Users.create_user(params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, gettext("Successfully created"))
        |> redirect(to: Routes.admin_user_path(conn, :new))

      {:error, changeset} ->
        conn
        |> put_flash(:error, gettext("Error occurred! Please fix the warnings"))
        |> render("new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    changeset = Users.change_user(user)

    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => params}) do
    user = Users.get_user!(id)

    case Users.update_user(user, params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, gettext("Successfully updated"))
        |> redirect(to: Routes.admin_user_path(conn, :edit, user.id))

      {:error, changeset} ->
        conn
        |> put_flash(:error, gettext("Error occurred! Please fix the warnings"))
        |> render("edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    {:ok, _} = Users.soft_delete_user(user)

    conn
    |> put_flash(:info, gettext("Successfully deleted"))
    |> redirect(to: Routes.admin_user_path(conn, :index))
  end
end
