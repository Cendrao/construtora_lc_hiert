defmodule ConstrutoraLcHiertWeb.ErrorViewTest do
  use ConstrutoraLcHiertWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.html" do
    assert render_to_string(ConstrutoraLcHiertWeb.ErrorView, "404.html", []) =~
             "Página não encontrada"
  end

  test "renders 500.html" do
    assert render_to_string(ConstrutoraLcHiertWeb.ErrorView, "500.html", []) =~
             "Ocorreu um problema"
  end
end
