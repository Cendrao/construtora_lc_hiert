defmodule ConstrutoraLcHiert.RealEstate.Properties.PropertyImage do
  @moduledoc """
  The property image schema.
  """

  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset

  alias ConstrutoraLcHiert.RealEstate.Properties.{Property, PropertyImage}
  alias ConstrutoraLcHiert.Storage

  schema "property_images" do
    field :image, Storage.Uploaders.Image.Type
    field :featured, :boolean, default: false

    belongs_to :property, Property

    timestamps()
  end

  def changeset(%PropertyImage{} = property_image, attrs) do
    attrs = Storage.change_upload_image_filename(attrs)

    property_image
    |> cast(attrs, [:property_id, :featured])
    |> cast_attachments(attrs, [:image])
    |> validate_required([:image, :property_id])
  end
end
