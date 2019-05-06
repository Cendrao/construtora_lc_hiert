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

  @doc """
  Currently using ImageKit (https://imagekit.io) to deal with images in production.
  It connects to the bucket on AWS S3 and give us a URL of the image.

  ## Examples:

      iex> full_url(image)
      "https://ik.imagekit.io/ricardoruwer/lchiert/uploads/1/image.jpg"

  """
  def full_url(image) do
    storage_dir = storage_dir(:original, {image.image, image})

    if Mix.env() == :prod do
      "https://ik.imagekit.io/ricardoruwer/lchiert/#{storage_dir}/#{image.image.file_name}"
    else
      "/#{storage_dir}/#{image.image.file_name}"
    end
  end
end
