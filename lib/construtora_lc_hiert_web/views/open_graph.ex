defmodule ConstrutoraLcHiertWeb.OpenGraph do
  use ConstrutoraLcHiertWeb, :view

  alias ConstrutoraLcHiertWeb.PropertyView
  alias ConstrutoraLcHiertWeb.PageTitle

  import Phoenix.Controller, only: [current_url: 1]

  @app_name "Construtora LC Hiert"

  def for({view, action, conn}) do
    {view, action, conn.assigns, current_url(conn)}
    |> meta_tags()
  end

  defp meta_tags({PropertyView, :show, %{property: property}, request_url}) do
    [
      %{property: "og:site_name", content: @app_name},
      %{property: "og:type", content: "website"},
      %{
        property: "og:title",
        content: PageTitle.for({PropertyView, :show, %{property: property}})
      },
      %{
        property: "og:description",
        content: "#{PropertyView.description(property)} @ #{@app_name}"
      },
      %{property: "og:url", content: request_url},
      %{
        property: "og:image",
        content: image_url(property.images, %{width: 1200, height: 630})
      }
    ]
    |> Enum.map(&meta_tag/1)
  end

  defp meta_tags(_), do: nil

  defp meta_tag(attrs) do
    tag(:meta, Enum.into(attrs, []))
  end
end
