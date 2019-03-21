defmodule ConstrutoraLcHiertWeb.EmailView do
  use ConstrutoraLcHiertWeb, :view

  def render_button(link, text) do
    render(ConstrutoraLcHiertWeb.EmailView, "_button.html", %{link: link, text: text})
  end
end
