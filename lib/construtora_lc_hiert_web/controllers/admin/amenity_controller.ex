defmodule ConstrutoraLcHiertWeb.Admin.AmenityController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.Amenities.Amenity
  alias ConstrutoraLcHiert.Amenities

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
end
