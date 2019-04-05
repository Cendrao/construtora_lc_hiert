defmodule ConstrutoraLcHiert.Properties.PropertySlug do
  use EctoAutoslugField.Slug, to: :slug

  import Ecto.Changeset

  alias ConstrutoraLcHiert.Properties

  @doc """
  Generates a slug using property attributes.

  ## Example

  When you define your schema like:

      schema "properties" do
        ...
        field :slug, PropertySlug.Type
      end

      def changeset(property, attrs) do
        ...
        |> PropertySlug.maybe_generate_slug()
        |> PropertySlug.unique_constraint()
      end

  It will generate, for example, the following value in "slug":

      "apartamento-rua-carlos-barbosa-1640-vila-industrial-toledo-pr"

  """
  def get_sources(changeset, _opts) do
    base_fields = [:address, :address_number, :complement, :neighborhood, :city, :state]

    if get_change(changeset, :type, false) do
      [Properties.translate_type(changeset.changes.type)] ++ base_fields
    else
      base_fields
    end
  end
end
