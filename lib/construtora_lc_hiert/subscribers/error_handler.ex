defmodule ConstrutoraLcHiert.Subscribers.ErrorHandler do
  def get_message(errors) do
    errors
    |> Enum.map(fn {field, {message, _}} -> "#{field} #{translate(message)}" end)
    |> Enum.join(" · ")
  end

  defp translate(message) do
    Gettext.dgettext(ConstrutoraLcHiertWeb.Gettext, "errors", message)
  end
end
