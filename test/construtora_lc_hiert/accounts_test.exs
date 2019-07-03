defmodule ConstrutoraLcHiert.AccountTest do
  use ConstrutoraLcHiert.DataCase
  use ConstrutoraLcHiert.Fixtures, [:user]

  alias ConstrutoraLcHiert.Account
  alias ConstrutoraLcHiert.Account.Users.User

  describe "verify_user_credentials/2" do
    test "with valid data returns the user" do
      user = user_fixture()

      assert {:ok, %User{} = user} = Account.verify_user_credentials(user.username, "rusbé")
    end

    test "with invalid username returns error not_found" do
      user = user_fixture()

      assert {:error, :not_found} = Account.verify_user_credentials("ERO!", user.password)
    end

    test "with invalid password returns error invalid_credentials" do
      user = user_fixture()

      assert {:error, :invalid_credentials} =
               Account.verify_user_credentials(user.username, "ERO!")
    end
  end
end
