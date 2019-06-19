defmodule ConstrutoraLcHiertWeb.Admin.Property.Image.FeaturedController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.Storage

  def create(conn, params) do
    image = Storage.get_property_image_by!(id: params["image"])

    {:ok, _} = Storage.set_featured_property_image(image)

    conn
    |> put_flash(:info, gettext("Successfully featured"))
    |> redirect(to: Routes.admin_property_image_path(conn, :new, params["property_id"]))
  end
end
