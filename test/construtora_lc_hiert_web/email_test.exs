defmodule ConstrutoraLcHiert.EmailTest do
  use ExUnit.Case
  use Bamboo.Test

  alias ConstrutoraLcHiertWeb.Email

  describe "contact_message" do
    test "assigns the correct data" do
      email =
        Email.contact_message("serjao@berrante.com", name: "Sergio", message: "Aqui tem coragem!")

      assert email.to == "construcao.lc@gmail.com"
      assert email.from == "serjao@berrante.com"
      assert email.subject == "Contato via site"
      assert email.html_body =~ "Aqui tem coragem!"
    end

    test "sends the email" do
      email =
        Email.contact_message("serjao@berrante.com", name: "Sergio", message: "Aqui tem coragem!")

      email |> ConstrutoraLcHiert.Mailer.deliver_now()

      assert_delivered_email(email)
    end
  end
end
