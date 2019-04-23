defmodule ConstrutoraLcHiertWeb.Helpers.IconHelperTest do
  use ConstrutoraLcHiertWeb.ConnCase, async: true

  import Phoenix.HTML, only: [safe_to_string: 1]

  alias ConstrutoraLcHiertWeb.Helpers.IconHelper

  describe "icon/1" do
    test "when given active" do
      image =
        IconHelper.icon("active")
        |> safe_to_string()

      assert String.match?(image, ~r/<img.*src="\/images\/icons\/active.svg".*>/)
    end

    test "when given delete" do
      image =
        IconHelper.icon("delete")
        |> safe_to_string()

      assert String.match?(image, ~r/<img.*src="\/images\/icons\/delete.svg".*>/)
    end
  end
end
