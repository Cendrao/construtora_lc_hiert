defmodule ConstrutoraLcHiert.SubscribersTest do
  use ConstrutoraLcHiert.DataCase

  alias ConstrutoraLcHiert.Subscribers
  alias ConstrutoraLcHiert.Subscribers.Subscriber

  @valid_attrs %{email: "ciro@bottini.com"}
  @invalid_attrs %{email: nil}

  describe "create_subscriber/1" do
    test "with valid data creates a subscriber" do
      assert {:ok, %Subscriber{} = subscriber} = Subscribers.create_subscriber(@valid_attrs)
      assert subscriber.email == "ciro@bottini.com"
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Subscribers.create_subscriber(@invalid_attrs)
    end
  end
end
