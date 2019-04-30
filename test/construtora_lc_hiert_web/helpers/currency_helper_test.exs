defmodule ConstrutoraLcHiertWeb.Helpers.CurrencyHelperTest do
  use ConstrutoraLcHiertWeb.ConnCase, async: true

  alias ConstrutoraLcHiertWeb.Helpers.CurrencyHelper

  describe "number_to_currency/2" do
    test "displays the currency when given a float" do
      number = 2_000_000.0

      assert CurrencyHelper.number_to_currency(number, unit: "R$ ", decimals: 2) ==
               "R$ 2.000.000,00"
    end

    test "displays the currency when given a string" do
      number = "2.000.000"

      assert CurrencyHelper.number_to_currency(number, unit: "R$ ", decimals: 2) ==
               "R$ 2.000.000,00"
    end
  end
end
