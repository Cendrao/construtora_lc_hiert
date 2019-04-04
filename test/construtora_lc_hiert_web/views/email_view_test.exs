defmodule ConstrutoraLcHiertWeb.EmailViewTest do
  use ConstrutoraLcHiertWeb.ConnCase, async: true

  import Phoenix.HTML, only: [safe_to_string: 1]

  alias ConstrutoraLcHiertWeb.EmailView

  test "render_button/2" do
    button =
      EmailView.render_button("http://www.pudim.com.br", "Pudim")
      |> safe_to_string()

    assert String.match?(button, ~r/<a.*href="http:\/\/www.pudim.com.br".*>Pudim<\/a>/)
  end
end
