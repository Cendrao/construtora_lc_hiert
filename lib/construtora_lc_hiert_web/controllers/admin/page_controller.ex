defmodule ConstrutoraLcHiertWeb.Admin.PageController do
  use ConstrutoraLcHiertWeb, :controller

  alias ConstrutoraLcHiert.Properties
  alias ConstrutoraLcHiert.Subscribers

  def index(conn, _params) do
    apartments_count = Properties.count_properties(:apartment)
    houses_count = Properties.count_properties(:house)
    lots_count = Properties.count_properties(:lot)
    total_count = apartments_count + houses_count + lots_count

    render(conn, "index.html",
      apartments_count: apartments_count,
      houses_count: houses_count,
      lots_count: lots_count,
      total_count: total_count,
      average_price_apartment: Properties.properties_avg_price(:apartment),
      cheapest_apartment: Properties.get_cheapest_property(:apartment),
      most_expensive_apartment: Properties.get_most_expensive_property(:apartment),
      average_price_house: Properties.properties_avg_price(:house),
      cheapest_house: Properties.get_cheapest_property(:house),
      most_expensive_house: Properties.get_most_expensive_property(:house),
      average_price_lot: Properties.properties_avg_price(:lot),
      cheapest_lot: Properties.get_cheapest_property(:lot),
      most_expensive_lot: Properties.get_most_expensive_property(:lot),
      properties_price_sum: Properties.properties_price_sum(),
      subscribers_count: Subscribers.count_subscribers()
    )
  end
end
