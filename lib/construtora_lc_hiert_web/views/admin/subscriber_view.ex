defmodule ConstrutoraLcHiertWeb.Admin.SubscriberView do
  use ConstrutoraLcHiertWeb, :view

  def status_image("active"), do: img_tag("/images/icons/check.png")
  def status_image("inactive"), do: img_tag("/images/icons/error.png")
end
