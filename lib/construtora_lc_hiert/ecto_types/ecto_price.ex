defmodule ConstrutoraLcHiert.EctoTypes.EctoPrice do
  @moduledoc """
  An EctoType to deal with Prices.
  """

  alias ConstrutoraLcHiertWeb.Helpers.CurrencyHelper

  @behaviour Ecto.Type
  def type, do: :float

  def cast(price) when is_binary(price) or is_number(price), do: {:ok, price}
  def cast(_), do: :error

  @doc """
  Removes all dots and then replaces the commas to dots when it is a String.
  It gets the data ready to be written to the database.

  ## Example:

      iex> dump("600.000,00")
      600000.00

  """
  def dump(price) when is_binary(price) do
    {float_price, _} =
      price
      |> String.replace(".", "")
      |> String.replace(",", ".")
      |> Float.parse()

    {:ok, float_price}
  end

  def dump(price) when is_float(price), do: {:ok, price}
  def dump(_), do: :error

  def load(price) when is_float(price) do
    {:ok, CurrencyHelper.number_to_currency(price)}
  end

  def load(_), do: :error
end
