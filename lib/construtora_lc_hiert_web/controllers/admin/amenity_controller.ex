defmodule ConstrutoraLcHiertWeb.Admin.AmenityController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.RealEstate.Amenities.Amenity
  alias ConstrutoraLcHiert.RealEstate.Amenities

  def index(conn, _params) do
    amenities = Amenities.list_amenities()

    render(conn, "index.html", %{amenities: amenities})
  end

  def new(conn, _params) do
    changeset = Amenity.changeset(%Amenity{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"amenity" => params}) do
    case Amenities.create_amenity(params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, gettext("Successfully created"))
        |> redirect(to: Routes.admin_amenity_path(conn, :new))

      {:error, changeset} ->
        conn
        |> put_flash(:error, gettext("Error occurred! Please fix the warnings"))
        |> render("new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    amenity = Amenities.get_amenity!(id)
    changeset = Amenity.changeset(amenity)

    render(conn, "edit.html", amenity: amenity, changeset: changeset)
  end

  def update(conn, %{"id" => id, "amenity" => params}) do
    amenity = Amenities.get_amenity!(id)

    case Amenities.update_amenity(amenity, params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, gettext("Successfully updated"))
        |> redirect(to: Routes.admin_amenity_path(conn, :edit, amenity.id))

      {:error, changeset} ->
        conn
        |> put_flash(:error, gettext("Error occurred! Please fix the warnings"))
        |> render("edit.html", amenity: amenity, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    amenity = Amenities.get_amenity!(id)

    {:ok, _} = Amenities.hard_delete_amenity(amenity)

    conn
    |> put_flash(:info, gettext("Successfully deleted"))
    |> redirect(to: Routes.admin_amenity_path(conn, :index))
  end
end
