defmodule ConstrutoraLcHiertWeb.Helpers.IconHelper do
  @moduledoc """
  Give some icons to be used on templates.
  """

  use Phoenix.HTML, only: [img_tag: 1]

  def icon(name, opts \\ %{width: "24px"}) do
    img_tag("/images/icons/#{name}.svg", width: opts[:width])
  end
end
