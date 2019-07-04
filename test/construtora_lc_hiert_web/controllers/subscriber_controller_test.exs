defmodule ConstrutoraLcHiertWeb.SubscriberControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase
  use ConstrutoraLcHiert.Fixtures, [:subscriber]

  alias ConstrutoraLcHiert.Customer.Subscribers

  describe "POST /inscritos" do
    test "creates a new active subscriber", %{conn: conn} do
      post(conn, "/inscritos", @valid_subscriber_attrs)

      subscriber = Subscribers.get_subscriber_by_email(@valid_subscriber_attrs.email)

      refute subscriber == nil
      assert subscriber.status == "active"
    end

    test "returns the json response when success", %{conn: conn} do
      conn = post(conn, "/inscritos", @valid_subscriber_attrs)

      assert json_response(conn, 200)["data"] =~ "Cadastrado com sucesso"
    end

    test "returns the json response when email is empty", %{conn: conn} do
      conn = post(conn, "/inscritos", @invalid_subscriber_attrs)

      assert json_response(conn, 500)["data"] =~ "Oops! email não pode ficar em branco"
    end

    test "activates the user when email is already registered", %{conn: conn} do
      subscriber = subscriber_fixture(%{status: "inactive"})

      conn = post(conn, "/inscritos", @valid_subscriber_attrs)

      assert Subscribers.get_subscriber_by_email(subscriber.email).status == "active"
      assert json_response(conn, 200)["data"] =~ "Cadastrado com sucesso"
    end
  end
end
