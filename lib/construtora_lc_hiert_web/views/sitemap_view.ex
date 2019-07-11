defmodule ConstrutoraLcHiertWeb.SitemapView do
  use ConstrutoraLcHiertWeb, :view

  @doc """
  Format the date to the sitemap format

  ## Examples

      iex> format_date(~N[2019-07-03 23:15:00])
      "2019-07-03"

  """
  def format_date(date) do
    date
    |> DateTime.from_naive!("Etc/UTC")
    |> DateTime.to_date()
    |> to_string()
  end
end
