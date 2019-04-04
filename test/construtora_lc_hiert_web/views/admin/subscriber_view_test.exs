defmodule ConstrutoraLcHiertWeb.SubscriberViewTest do
  use ConstrutoraLcHiertWeb.ConnCase, async: true

  import Phoenix.HTML, only: [safe_to_string: 1]

  alias ConstrutoraLcHiertWeb.Admin.SubscriberView

  test "status_image/1 when active" do
    image =
      SubscriberView.status_image("active")
      |> safe_to_string()

    assert String.match?(image, ~r/<img.*src="\/images\/icons\/check.png".*>/)
  end

  test "status_image/1 when inactive" do
    image =
      SubscriberView.status_image("inactive")
      |> safe_to_string()

    assert String.match?(image, ~r/<img.*src="\/images\/icons\/error.png".*>/)
  end
end
