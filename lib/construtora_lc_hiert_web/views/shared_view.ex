defmodule ConstrutoraLcHiertWeb.SharedView do
  use ConstrutoraLcHiertWeb, :view

  def render_shared(template, assigns \\ []) do
    render(ConstrutoraLcHiertWeb.SharedView, template, assigns)
  end
end
