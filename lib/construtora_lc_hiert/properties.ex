defmodule ConstrutoraLcHiert.Properties do
  @moduledoc """
  The Properties context.
  """

  import Ecto.Query, warn: false

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.Properties.Property

  @doc """
  Creates a property.

  ## Examples

      iex> create_property(%{address: "Rua X", address_number: 6, city: "Toledo", ...})
      {:ok, %Property{}}

      iex> create_property(%{address: nil, address_number: nil, city: nil, ...})
      {:error, %Ecto.Changeset{}}

  """
  def create_property(attrs \\ %{}) do
    %Property{}
    |> Property.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns the list of properties.

  ## Examples

      iex> list_properties()
      [%Property{}, ...]

  """
  def list_properties do
    Repo.all(Property)
  end

  @doc """
  Translate the type to a readable name to the user.

  ## Examples

      iex> translate_type(:apartment)
      "Apartment"

  """
  def translate_type(:apartment), do: Gettext.gettext(ConstrutoraLcHiertWeb.Gettext, "Apartment")
  def translate_type(:house), do: Gettext.gettext(ConstrutoraLcHiertWeb.Gettext, "House")
  def translate_type(:lot), do: Gettext.gettext(ConstrutoraLcHiertWeb.Gettext, "Lot")
end
