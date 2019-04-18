defmodule ConstrutoraLcHiert.EctoTypes.EctoPriceTest do
  use ConstrutoraLcHiert.DataCase

  alias ConstrutoraLcHiert.EctoTypes.EctoPrice

  describe "cast/1" do
    test "returns a string when given string" do
      assert EctoPrice.cast("80000.0") == {:ok, "80000.0"}
    end

    test "returns a float when given integer" do
      assert EctoPrice.cast(200_000.0) == {:ok, 200_000.0}
    end

    test "returns a float when given float" do
      assert EctoPrice.cast(800_000) == {:ok, 800_000.0}
    end
  end

  describe "dump/1" do
    test "returns a float when given string" do
      assert EctoPrice.dump("600.000") == {:ok, 600_000.0}
      assert EctoPrice.dump("40000") == {:ok, 40_000.0}
      assert EctoPrice.dump("200.000,00") == {:ok, 200_000.0}
      assert EctoPrice.dump("10000,00") == {:ok, 10_000.0}
    end

    test "returns a float when given float" do
      assert EctoPrice.dump(600_000.0) == {:ok, 600_000.0}
    end

    test "returns error when given integer" do
      assert EctoPrice.dump(80_000) == :error
    end
  end

  describe "load/1" do
    test "returns a float when given float" do
      assert EctoPrice.load(5_000.0) == {:ok, 5_000.0}
    end

    test "returns error when given integer" do
      assert EctoPrice.load(5_000) == :error
    end

    test "returns error when given string" do
      assert EctoPrice.load("5000") == :error
    end
  end
end
