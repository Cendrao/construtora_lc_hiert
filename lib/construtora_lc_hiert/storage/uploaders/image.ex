defmodule ConstrutoraLcHiert.Storage.Uploaders.Image do
  use Arc.Definition
  use Arc.Ecto.Definition

  @versions [:original]

  def storage_dir(_version, {_file, scope}) do
    if Mix.env() == :test do
      "uploads/test/#{scope.property_id}"
    else
      "uploads/#{scope.property_id}"
    end
  end
end
