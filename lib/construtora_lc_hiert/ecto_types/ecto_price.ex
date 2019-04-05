defmodule ConstrutoraLcHiert.EctoTypes.EctoPrice do
  @behaviour Ecto.Type
  def type, do: :float

  @doc """
  It removes all dots and then replaces the commas to dots when it is a String.

  ## Example:

      iex> cast("600.000,00")
      600000.00

  """
  def cast(price) when is_binary(price) do
    {float_price, _} =
      price
      |> String.replace(".", "")
      |> String.replace(",", ".")
      |> Float.parse()

    {:ok, float_price}
  end

  def cast(price) when is_number(price), do: {:ok, price}
  def cast(_), do: :error

  def dump(price) when is_float(price), do: {:ok, price}
  def dump(_), do: :error

  def load(price) when is_float(price), do: {:ok, price}
  def load(_), do: :error
end
