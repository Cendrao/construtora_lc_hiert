defmodule ConstrutoraLcHiert.Storage.PropertyImage do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  alias ConstrutoraLcHiert.Properties.Property
  alias ConstrutoraLcHiert.Storage.Uploaders
  alias ConstrutoraLcHiert.Storage.PropertyImage

  schema "property_images" do
    field :image, Uploaders.Image.Type

    belongs_to :property, Property

    timestamps()
  end

  @doc false
  def changeset(%PropertyImage{} = property_image, attrs) do
    attrs = change_filename(attrs)

    property_image
    |> cast(attrs, [:property_id])
    |> cast_attachments(attrs, [:image])
    |> validate_required([:image, :property_id])
  end

  defp change_filename(%{"image" => %Plug.Upload{filename: name} = image} = attrs) do
    image = %Plug.Upload{image | filename: create_filename(name)}
    %{attrs | "image" => image}
  end

  defp create_filename(name) do
    extension = Path.extname(name)

    "construtora_lc_hiert_#{:os.system_time()}" <> extension
  end
end
