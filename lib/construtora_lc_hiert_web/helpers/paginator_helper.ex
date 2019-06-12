defmodule ConstrutoraLcHiertWeb.Helpers.PaginatorHelper do
  @moduledoc """
  Renders a pagination with a previous button, the pages and next button.
  """

  use Phoenix.HTML

  alias ConstrutoraLcHiertWeb.Helpers.IconHelper

  def render(conn, data, class: class) do
    first = prev_button(conn, data)
    pages = page_buttons(data)
    last = next_button(conn, data)

    content_tag(:ul, [first, pages, last], class: class)
  end

  defp prev_button(conn, data) do
    page = data.current_page - 1
    disabled = data.current_page == 1

    content_tag(:li, disabled: disabled) do
      link to: "?page=#{page}" do
        IconHelper.icon_tag(conn, "left-arrow")
      end
    end
  end

  defp page_buttons(data) do
    for page <- 1..data.total_pages do
      class = if data.current_page == page, do: "active"
      disabled = data.current_page == page

      content_tag(:li, class: class, disabled: disabled) do
        link(page, to: "?page=#{page}")
      end
    end
  end

  defp next_button(conn, data) do
    page = data.current_page + 1
    disabled = data.current_page >= data.total_pages

    content_tag(:li, disabled: disabled) do
      link to: "?page=#{page}" do
        IconHelper.icon_tag(conn, "right-arrow")
      end
    end
  end
end
