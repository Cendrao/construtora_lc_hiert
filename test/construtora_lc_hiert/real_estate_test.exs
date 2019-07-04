defmodule ConstrutoraLcHiert.RealEstateTest do
  use ConstrutoraLcHiert.DataCase
  use ConstrutoraLcHiert.Fixtures, [:property, :subscriber]
  use Bamboo.Test

  alias ConstrutoraLcHiertWeb.Email
  alias ConstrutoraLcHiert.RealEstate.Properties.Property
  alias ConstrutoraLcHiert.RealEstate

  describe "register_property/1" do
    test "with valid data creates a property" do
      assert {:ok, %Property{}} = RealEstate.register_property(@valid_property_attrs)
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RealEstate.register_property(@invalid_property_attrs)
    end

    test "sends an email to all active subscribers" do
      subscriber = subscriber_fixture(%{status: "active"})

      {:ok, property} = RealEstate.register_property(@valid_property_attrs)

      assert_delivered_email(
        Email.subscriber_message(subscriber.email, property: property, subscriber: subscriber)
      )
    end

    test "does not send email to inactive subscribers" do
      subscriber_fixture(%{status: "inactive"})

      RealEstate.register_property(@valid_property_attrs)

      assert_no_emails_delivered()
    end
  end
end
