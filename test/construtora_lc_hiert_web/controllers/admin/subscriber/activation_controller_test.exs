defmodule ConstrutoraLcHiertWeb.Admin.Subscriber.ActivationControllerTest do
  use ConstrutoraLcHiertWeb.ConnCase

  alias ConstrutoraLcHiert.Subscribers

  describe "POST /admin/inscritos/:id/ativacao" do
    setup [:create_subscriber]

    @tag :sign_in_user
    test "activates the subscriber", %{conn: conn, subscriber: subscriber} do
      conn = post(conn, "/admin/inscritos/#{subscriber.id}/ativacao")

      assert get_flash(conn, :info) =~ "Ativado com sucesso"
      assert redirected_to(conn) =~ "/admin/inscritos"
    end
  end

  describe "DELETE /admin/inscritos/:id/ativacao" do
    setup [:create_subscriber]

    @tag :sign_in_user
    test "deactivates the subscriber", %{conn: conn, subscriber: subscriber} do
      conn = delete(conn, "/admin/inscritos/#{subscriber.id}/ativacao")

      assert get_flash(conn, :info) =~ "Desativado com sucesso"
      assert redirected_to(conn) =~ "/admin/inscritos"
    end
  end

  defp create_subscriber(_) do
    {:ok, subscriber} = Subscribers.create_subscriber(%{email: "lindomar@subzero.br"})
    {:ok, subscriber: subscriber}
  end
end
