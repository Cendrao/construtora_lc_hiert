defmodule ConstrutoraLcHiertWeb.SitemapViewTest do
  use ConstrutoraLcHiertWeb.ConnCase, async: true

  alias ConstrutoraLcHiertWeb.SitemapView

  test "format_date/1" do
    assert SitemapView.format_date(~N[2019-07-03 23:15:00]) == "2019-07-03"
  end
end
