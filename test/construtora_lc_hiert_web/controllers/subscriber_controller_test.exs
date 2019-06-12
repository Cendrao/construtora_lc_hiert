defmodule ConstrutoraLcHiertWeb.SubscriberControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase
  use ConstrutoraLcHiert.Fixtures, [:subscriber]

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.Subscribers.Subscriber

  describe "POST /inscritos" do
    test "creates a new active subscriber", %{conn: conn} do
      post(conn, "/inscritos", @valid_subscriber_attrs)

      assert Repo.get_by!(Subscriber, email: "ciro@bottini.com").status == "active"
    end

    test "returns the json response when success", %{conn: conn} do
      conn = post(conn, "/inscritos", @valid_subscriber_attrs)

      assert json_response(conn, 200)["data"] =~ "Cadastrado com sucesso"
    end

    test "returns the json response when email is empty", %{conn: conn} do
      conn = post(conn, "/inscritos", @invalid_subscriber_attrs)

      assert json_response(conn, 500)["data"] =~ "Oops! email não pode ficar em branco"
    end

    test "returns the json response when email is already registered", %{conn: conn} do
      %Subscriber{} |> Subscriber.changeset(@valid_subscriber_attrs) |> Repo.insert!()

      conn = post(conn, "/inscritos", @valid_subscriber_attrs)

      assert json_response(conn, 500)["data"] =~ "Oops! email já está cadastrado"
    end
  end
end
