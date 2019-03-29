defmodule ConstrutoraLcHiert.SubscribersTest do
  use ConstrutoraLcHiert.DataCase

  alias ConstrutoraLcHiert.Subscribers
  alias ConstrutoraLcHiert.Subscribers.Subscriber

  @valid_attrs %{email: "ciro@bottini.com"}
  @invalid_attrs %{email: nil}

  def subscriber_fixture(attrs \\ %{}) do
    {:ok, subscriber} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Subscribers.create_subscriber()

    subscriber
  end

  describe "create_subscriber/1" do
    test "with valid data creates a subscriber" do
      assert {:ok, %Subscriber{} = subscriber} = Subscribers.create_subscriber(@valid_attrs)
      assert subscriber.email == "ciro@bottini.com"
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Subscribers.create_subscriber(@invalid_attrs)
    end
  end

  describe "list_subscribers/0" do
    test "returns all subscribers" do
      subscriber = subscriber_fixture()
      assert Subscribers.list_subscribers() == [subscriber]
    end
  end
end
