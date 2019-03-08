defmodule ConstrutoraLcHiert.AccountsTest do
  use ConstrutoraLcHiert.DataCase

  alias ConstrutoraLcHiert.Accounts
  alias ConstrutoraLcHiert.Accounts.User
  alias Comeonin.Bcrypt

  @valid_attrs %{password: "valid_password", username: "valid_username"}
  @update_attrs %{password: "valid_updated_password", username: "valid_updated_username"}
  @invalid_attrs %{password: nil, username: nil}

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Accounts.create_user()

    user
  end

  test "list_users/0 returns all users" do
    user = user_fixture()
    assert Accounts.list_users() == [user]
  end

  test "get_user!/1 returns the user with given id" do
    user = user_fixture()
    assert Accounts.get_user!(user.id) == user
  end

  describe "create_user/1" do
    test "with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert Bcrypt.checkpw("valid_password", user.password)
      assert user.username == "valid_username"
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end
  end

  describe "update_user/2" do
    test "with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert Bcrypt.checkpw("valid_updated_password", user.password)
      assert user.username == "valid_updated_username"
    end

    test "with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end
  end

  test "delete_user/1 deletes the user" do
    user = user_fixture()
    assert {:ok, %User{}} = Accounts.delete_user(user)
    assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
  end

  test "change_user/1 returns a user changeset" do
    user = user_fixture()
    assert %Ecto.Changeset{} = Accounts.change_user(user)
  end

  describe "verify_user_credentials/2" do
    test "with valid data returns the user" do
      user = user_fixture()

      assert {:ok, %User{} = user} =
               Accounts.verify_user_credentials(user.username, "valid_password")
    end

    test "with invalid username returns error not_found" do
      assert {:error, :not_found} =
               Accounts.verify_user_credentials("invalid_username", "some_password")
    end

    test "with invalid password returns error invalid_credentials" do
      user = user_fixture()

      assert {:error, :invalid_credentials} =
               Accounts.verify_user_credentials(user.username, "invalid_password")
    end
  end
end
