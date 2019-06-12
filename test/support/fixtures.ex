defmodule ConstrutoraLcHiert.Fixtures do
  @moduledoc """
  A module for defining fixtures that can be used in tests.

  This module can be used with a list of fixtures to apply as parameter.

      use ConstrutoraLcHiert.Fixtures, [:property, :amenity]
  """

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.Properties
  alias ConstrutoraLcHiert.Accounts
  alias ConstrutoraLcHiert.Amenities
  alias ConstrutoraLcHiert.Subscribers

  def property do
    quote do
      @valid_property_attrs %{
        "address" => "Rua Carlos Barbosa",
        "address_number" => "1650",
        "area" => "50",
        "city" => "Toledo",
        "complement" => "",
        "description" => "Lorem ipsum dolor sit amet.",
        "neighborhood" => "Vila Industrial",
        "price" => "1.000.000",
        "qty_bathrooms" => "2",
        "qty_garages" => "2",
        "qty_kitchens" => "1",
        "qty_rooms" => "3",
        "state" => "PR",
        "type" => :apartment
      }
      @update_property_attrs %{
        "address" => "Rua do Paraíso",
        "address_number" => "595",
        "area" => "150",
        "city" => "São Paulo",
        "complement" => "",
        "description" => "",
        "neighborhood" => "Paraíso",
        "price" => "2.000.000",
        "qty_bathrooms" => "4",
        "qty_garages" => "8",
        "qty_kitchens" => "1",
        "qty_rooms" => "1",
        "state" => "SP",
        "type" => :apartment
      }
      @invalid_property_attrs %{
        "address" => nil,
        "address_number" => nil,
        "area" => nil,
        "city" => nil,
        "complement" => nil,
        "description" => nil,
        "neighborhood" => nil,
        "price" => nil,
        "qty_bathrooms" => nil,
        "qty_garages" => nil,
        "qty_kitchens" => nil,
        "qty_rooms" => nil,
        "state" => nil,
        "type" => nil
      }

      def property_fixture(attrs \\ %{}) do
        {:ok, property} =
          attrs
          |> Enum.into(@valid_property_attrs)
          |> Properties.create_property()

        Repo.preload(property, [:images, :amenities])
      end
    end
  end

  def user do
    quote do
      @valid_user_attrs %{password: "rusbé", username: "biridin"}
      @update_user_attrs %{password: "rusbé_updated", username: "biridin_updated"}
      @invalid_user_attrs %{password: nil, username: nil}

      def user_fixture(attrs \\ %{}) do
        {:ok, user} =
          attrs
          |> Enum.into(@valid_user_attrs)
          |> Accounts.create_user()

        user
      end
    end
  end

  def amenity do
    quote do
      @valid_amenity_attrs %{name: "Piscina"}
      @update_amenity_attrs %{name: "Ar condicionado"}
      @invalid_amenity_attrs %{name: nil}

      def amenity_fixture(attrs \\ %{}) do
        {:ok, amenity} =
          attrs
          |> Enum.into(@valid_amenity_attrs)
          |> Amenities.create_amenity()

        amenity
      end
    end
  end

  def subscriber do
    quote do
      @valid_subscriber_attrs %{email: "ciro@bottini.com"}
      @invalid_subscriber_attrs %{email: nil}

      def subscriber_fixture(attrs \\ %{}) do
        {:ok, subscriber} =
          attrs
          |> Enum.into(@valid_subscriber_attrs)
          |> Subscribers.create_subscriber()

        subscriber
      end
    end
  end

  @doc """
  Apply the fixtures
  """
  defmacro __using__(fixtures) when is_list(fixtures) do
    for fixture <- fixtures, is_atom(fixture), do: apply(__MODULE__, fixture, [])
  end
end
