defmodule ConstrutoraLcHiert.RealEstate do
  @moduledoc """
  The Real Estate context.
  """

  alias ConstrutoraLcHiertWeb.Email
  alias ConstrutoraLcHiert.Customer.Subscribers
  alias ConstrutoraLcHiert.RealEstate.Properties

  @doc """
  Creates the property and send an email to all active subscribers
  """
  def register_property(attrs) do
    property = Properties.create_property(attrs)
    send_email_to_subscribers(property)

    property
  end

  defp send_email_to_subscribers({:ok, property}) do
    :active
    |> Subscribers.list_subscribers()
    |> Enum.each(fn subscriber ->
      subscriber.email
      |> Email.subscriber_message(property: property, subscriber: subscriber)
      |> Email.deliver_now()
    end)
  end

  defp send_email_to_subscribers(error), do: error
end
