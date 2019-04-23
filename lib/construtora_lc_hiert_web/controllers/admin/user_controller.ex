defmodule ConstrutoraLcHiertWeb.Admin.UserController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.Accounts.User
  alias ConstrutoraLcHiert.Accounts

  def index(conn, _params) do
    users = Accounts.list_users()

    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = User.changeset(user)

    render(conn, "show.html", user: user, changeset: changeset)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => params}) do
    case Accounts.create_user(params) do
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
    user = Accounts.get_user!(id)
    changeset = User.changeset(user)

    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, params) do
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
    user = Accounts.get_user!(id)

    {:ok, _} = Accounts.soft_delete_user(user)

    conn
    |> put_flash(:info, gettext("Successfully deleted"))
    |> redirect(to: Routes.admin_user_path(conn, :index))
  end
end
