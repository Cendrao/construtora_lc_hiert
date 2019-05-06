defmodule ConstrutoraLcHiert.Storage.Uploaders.ImageTest do
  use ConstrutoraLcHiert.DataCase

  alias ConstrutoraLcHiert.Storage.Uploaders.Image

  describe "full_url/1" do
    image = %{image: %{file_name: "blah.jpg"}, property_id: 3}

    assert Image.full_url(image) == "/uploads/test/3/blah.jpg"
  end
end
