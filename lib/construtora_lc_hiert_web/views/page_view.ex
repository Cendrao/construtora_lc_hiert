defmodule ConstrutoraLcHiertWeb.PageView do
  use ConstrutoraLcHiertWeb, :view

  def render_shared(template, assigns \\ []) do
    render(ConstrutoraLcHiertWeb.Page.SharedView, template, assigns)
  end
end
