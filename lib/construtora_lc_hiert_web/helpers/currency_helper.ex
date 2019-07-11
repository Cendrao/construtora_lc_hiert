defmodule ConstrutoraLcHiertWeb.Helpers.CurrencyHelper do
  @moduledoc """
  Give some currency helper functions.
  """

  @doc """
  Transform the given number into a currency.

  ## Examples

      iex> number_to_currency(2_000_000.00, unit: "R$ ", decimals: 2)
      "R$ 2.000.000,00"

      iex> number_to_currency(2_000_000, unit: "R$ ", decimals: 2)
      "R$ 2.000.000,00"

      iex> number_to_currency("2.000.000", unit: "R$ ", decimals: 2)
      "R$ 2.000.000,00"

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

  defp get_only_numbers(value) when is_binary(value) do
    {new_value, _} =
      ~r/[^\d]/
      |> Regex.replace(value, "")
      |> Float.parse()

    new_value
  end

  defp get_only_numbers(value) do
    value
    |> to_string()
    |> get_only_numbers()
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
