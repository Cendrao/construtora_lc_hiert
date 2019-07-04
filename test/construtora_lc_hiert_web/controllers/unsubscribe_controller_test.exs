defmodule ConstrutoraLcHiertWeb.UnsubscribeControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase
  use ConstrutoraLcHiert.Fixtures, [:subscriber]

  describe "GET /inscritos/desinscrever/:uuid" do
    test "accesses the page of unsubscribe when the subscriber exists", %{conn: conn} do
      subscriber = subscriber_fixture()

      conn = get(conn, "/inscritos/desinscrever/#{subscriber.uuid}")

      assert html_response(conn, 200) =~ "descadastrar da nossa lista"
    end

    test "raises no results error when subscriber does not exists", %{conn: conn} do
      assert_raise Ecto.NoResultsError, fn ->
        get(conn, "/inscritos/desinscrever/c56a4180-65aa-42ec-a945-5fd21dec0538")
      end
    end
  end

  describe "DELETE /inscritos/desinscrever/:uuid" do
    test "inactivates the user when given a valid uuid", %{conn: conn} do
      subscriber = subscriber_fixture()

      conn = delete(conn, "/inscritos/desinscrever/#{subscriber.uuid}")

      assert html_response(conn, 200) =~ "Você está descadastrado"
    end

    test "returns error when given a wrong uuid", %{conn: conn} do
      assert_raise Ecto.NoResultsError, fn ->
        delete(conn, "/inscritos/desinscrever/c56a4180-65aa-42ec-a945-5fd21dec0538")
      end
    end
  end
end
