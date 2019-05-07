defmodule ConstrutoraLcHiertWeb.Admin.Property.ImageView do
  use ConstrutoraLcHiertWeb, :view

  def image_url(image, opts) do
    ConstrutoraLcHiertWeb.PropertyView.image_url(image, opts)
  end
end
