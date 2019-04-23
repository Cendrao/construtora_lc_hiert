defmodule ConstrutoraLcHiertWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  alias ConstrutoraLcHiert.Authentication.Guardian
  alias ConstrutoraLcHiert.Accounts

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      alias ConstrutoraLcHiertWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint ConstrutoraLcHiertWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(ConstrutoraLcHiert.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(ConstrutoraLcHiert.Repo, {:shared, self()})
    end

    if tags[:sign_in_user] do
      {:ok, user} = Accounts.create_user(%{username: "maico", password: "rusbé"})

      conn = Guardian.Plug.sign_in(Phoenix.ConnTest.build_conn(), user)

      {:ok, conn: conn, user: user}
    else
      {:ok, conn: Phoenix.ConnTest.build_conn()}
    end
  end
end
