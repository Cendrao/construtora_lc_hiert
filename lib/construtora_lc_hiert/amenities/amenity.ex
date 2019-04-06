defmodule ConstrutoraLcHiert.Amenities.Amenity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "amenities" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(amenity, attrs \\ %{}) do
    amenity
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
