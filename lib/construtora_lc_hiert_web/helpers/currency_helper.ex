defmodule ConstrutoraLcHiertWeb.Helpers.CurrencyHelper do
  @moduledoc """
  Give some currency helper functions.
  """

  def number_to_currency(number, opts \\ [decimals: 0, unit: ""])

  def number_to_currency(number, opts) when is_float(number) do
    number
    |> :erlang.float_to_binary(decimals: 0)
    |> number_to_currency(opts)
  end

  def number_to_currency(number, opts) do
    number
    |> get_only_numbers()
    |> add_decimals(opts[:decimals])
    |> add_thousands_separator()
    |> add_unit_prefix(opts[:unit])
  end

  defp get_only_numbers(value) do
    {float_value, _} = Float.parse(Regex.replace(~r/[^\d]/, value, ""))

    float_value
  end

  defp add_decimals(value, decimals) do
    value
    |> :erlang.float_to_binary(decimals: decimals)
    |> String.replace(".", ",")
  end

  defp add_thousands_separator(value) do
    Regex.replace(~r/(\d)(?=(\d{3})+(?!\d))/, value, "\\1.")
  end

  defp add_unit_prefix(value, unit) do
    "#{unit}#{value}"
  end
end
