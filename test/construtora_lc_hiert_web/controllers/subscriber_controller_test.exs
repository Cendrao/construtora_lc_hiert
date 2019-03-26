defmodule ConstrutoraLcHiertWeb.SubscriberControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase

  alias ConstrutoraLcHiert.Repo
  alias ConstrutoraLcHiert.Subscribers.Subscriber

  @valid_params %{email: "ciro@bottini.com"}
  @invalid_params %{email: nil}

  describe "POST /subscriber" do
    test "creates a new active subscriber", %{conn: conn} do
      post(conn, "/subscriber", @valid_params)

      assert Repo.get_by!(Subscriber, email: "ciro@bottini.com").status == "active"
    end

    test "returns the json response when success", %{conn: conn} do
      conn = post(conn, "/subscriber", @valid_params)

      body = json_response(conn, 200)
      assert body["data"] =~ "Cadastrado com sucesso"
    end

    test "returns the json response when email is empty", %{conn: conn} do
      conn = post(conn, "/subscriber", @invalid_params)

      body = json_response(conn, 500)
      assert body["data"] =~ "Oops! email não pode ficar em branco"
    end

    test "returns the json response when email is already registered", %{conn: conn} do
      %Subscriber{} |> Subscriber.changeset(@valid_params) |> Repo.insert!()

      conn = post(conn, "/subscriber", @valid_params)

      body = json_response(conn, 500)
      assert body["data"] =~ "Oops! email já está cadastrado"
    end
  end
end
