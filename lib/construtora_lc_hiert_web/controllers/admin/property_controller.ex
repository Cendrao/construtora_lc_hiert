defmodule ConstrutoraLcHiertWeb.Admin.PropertyController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.Properties.Property
  alias ConstrutoraLcHiert.Properties
  alias ConstrutoraLcHiert.Amenities

  plug :load_amenities when action in [:new, :create, :edit, :update]

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

  def edit(conn, %{"id" => id}) do
    property = Properties.get_property!(id)
    changeset = Property.changeset(property)

    render(conn, "edit.html", property: property, changeset: changeset)
  end

  def update(conn, %{"id" => id, "property" => params}) do
    property = Properties.get_property!(id)

    case Properties.update_property(property, params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, gettext("Successfully updated"))
        |> redirect(to: Routes.admin_property_path(conn, :edit, property.id))

      {:error, changeset} ->
        conn
        |> put_flash(:error, gettext("Error occurred! Please fix the warnings"))
        |> render("edit.html", property: property, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    property = Properties.get_property!(id)

    {:ok, _} = Properties.soft_delete_property(property)

    conn
    |> put_flash(:info, gettext("Successfully deleted"))
    |> redirect(to: Routes.admin_property_path(conn, :index))
  end

  defp load_amenities(conn, _) do
    assign(conn, :amenities, Amenities.list_amenities())
  end
end
