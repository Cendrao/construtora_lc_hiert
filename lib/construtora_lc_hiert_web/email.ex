defmodule ConstrutoraLcHiertWeb.Email do
  use Bamboo.Phoenix, view: ConstrutoraLcHiertWeb.EmailView

  def contact_message(email, name, message) do
    new_email()
    |> put_html_layout({ConstrutoraLcHiertWeb.LayoutView, "email.html"})
    |> from(email)
    |> put_header("Reply-To", email)
    |> to("construcao.lc@gmail.com")
    |> subject("Contato via site")
    |> assign(:name, name)
    |> assign(:message, message)
    |> render(:contact_message)
  end
end
