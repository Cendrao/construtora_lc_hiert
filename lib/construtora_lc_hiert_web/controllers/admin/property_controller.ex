defmodule ConstrutoraLcHiertWeb.Admin.PropertyController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.Properties.Property
  alias ConstrutoraLcHiert.Properties
  alias ConstrutoraLcHiert.Amenities

  plug :load_amenities when action in [:new, :create]

  def index(conn, _params) do
    properties = Properties.list_properties()

    render(conn, "index.html", %{properties: properties})
  end

  def new(conn, _params) do
    changeset = Properties.change_property(%Property{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"property" => params}) do
    case Properties.create_property(params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, gettext("Successfully created"))
        |> redirect(to: Routes.admin_property_path(conn, :new))

      {:error, changeset} ->
        data = Properties.load_amenities(changeset.data)

        conn
        |> put_flash(:error, gettext("Error occurred! Please fix the warnings"))
        |> render("new.html", changeset: %{changeset | data: data})
    end
  end

  defp load_amenities(conn, _) do
    assign(conn, :amenities, Amenities.list_amenities())
  end
end
