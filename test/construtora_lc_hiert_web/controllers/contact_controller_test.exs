defmodule ConstrutoraLcHiertWeb.ContactControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase
  use Bamboo.Test

  alias ConstrutoraLcHiertWeb.Email

  @valid_params %{email: "guitar@human.com", name: "Guitarra", message: "Solta a pisadinha!"}
  @invalid_params %{email: nil, name: "Guitarra", message: "Solta a pisadinha!"}

  describe "GET /contato" do
    test "accesses the contact page", %{conn: conn} do
      conn = get(conn, "/contato")

      assert html_response(conn, 200) =~ "Envie uma mensagem"
    end
  end

  describe "POST /contato" do
    test "sends the email", %{conn: conn} do
      post(conn, "/contato", @valid_params)

      assert_delivered_email(
        Email.contact_message("guitar@human.com", "Guitarra", "Solta a pisadinha!")
      )
    end

    test "returns the json response when success", %{conn: conn} do
      conn = post(conn, "/contato", @valid_params)

      assert json_response(conn, 200)["data"] =~ "enviada com sucesso"
    end

    test "returns the json response when failure", %{conn: conn} do
      conn = post(conn, "/contato", @invalid_params)

      assert json_response(conn, 500)["data"] =~ "mensagem não foi enviada"
    end
  end
end
