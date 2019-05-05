defmodule ConstrutoraLcHiertWeb.Admin.Property.ImageController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.Properties
  alias ConstrutoraLcHiert.Storage

  def new(conn, %{"property_id" => id}) do
    property = Properties.get_property!(id)

    render(conn, "new.html", property: property)
  end

  def create(conn, params) do
    case Storage.create_property_image(params) do
      {:ok, _} ->
        json(conn, %{data: gettext("Successfully created")})

      {:error, _} ->
        conn |> put_status(500) |> json(%{data: gettext("The file was not uploaded")})
    end
  end
end
