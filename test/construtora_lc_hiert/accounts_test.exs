defmodule ConstrutoraLcHiert.AccountsTest do
  use ConstrutoraLcHiert.DataCase

  alias ConstrutoraLcHiert.Accounts
  alias ConstrutoraLcHiert.Accounts.User
  alias Comeonin.Bcrypt

  @valid_attrs %{password: "rusbé", username: "biridin"}
  @update_attrs %{password: "rusbé_updated", username: "biridin_updated"}
  @invalid_attrs %{password: nil, username: nil}

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Accounts.create_user()

    user
  end

  describe "list_users/0" do
    test "returns all users" do
      user = user_fixture()

      assert Accounts.list_users() == [user]
    end

    test "does not return soft deleted users" do
      user = user_fixture(%{deleted_at: NaiveDateTime.utc_now()})

      refute Accounts.list_users() == [user]
    end
  end

  test "get_user!/1 returns the user with given id" do
    user = user_fixture()

    assert Accounts.get_user!(user.id) == user
  end

  describe "create_user/1" do
    test "with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert Bcrypt.checkpw("rusbé", user.password)
      assert user.username == "biridin"
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{} = changeset} = Accounts.create_user(@invalid_attrs)
      assert %{username: ["can't be blank"], password: ["can't be blank"]} = errors_on(changeset)
    end

    test "with invalid password_confirmation returns error changeset" do
      attrs = %{username: "maico", password: "rusbé", password_confirmation: "biridin"}

      assert {:error, %Ecto.Changeset{} = changeset} = Accounts.create_user(attrs)
      assert %{password_confirmation: ["does not match confirmation"]} = errors_on(changeset)
    end

    test "with invalid password length returns error changeset" do
      attrs = %{username: "maico", password: "oq?", password_confirmation: "oq?"}

      assert {:error, %Ecto.Changeset{} = changeset} = Accounts.create_user(attrs)
      assert %{password: ["should be at least 5 character(s)"]} = errors_on(changeset)
    end
  end

  describe "update_user/2" do
    test "with valid data updates the user" do
      user = user_fixture()

      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert Bcrypt.checkpw("rusbé_updated", user.password)
      assert user.username == "biridin_updated"
    end

    test "with invalid data returns error changeset" do
      user = user_fixture()

      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end
  end

  test "soft_delete_user/1 deletes the user" do
    user = user_fixture()

    assert {:ok, %User{}} = Accounts.soft_delete_user(user)
    refute Accounts.get_user!(user.id).deleted_at == nil
  end

  test "hard_delete_user/1 deletes the user" do
    user = user_fixture()

    assert {:ok, %User{}} = Accounts.hard_delete_user(user)
    assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
  end

  test "change_user/1 returns a user changeset" do
    user = user_fixture()

    assert %Ecto.Changeset{} = Accounts.change_user(user)
  end

  describe "verify_user_credentials/2" do
    test "with valid data returns the user" do
      user = user_fixture()

      assert {:ok, %User{} = user} = Accounts.verify_user_credentials(user.username, "rusbé")
    end

    test "with invalid username returns error not_found" do
      user = user_fixture()

      assert {:error, :not_found} = Accounts.verify_user_credentials("ERO!", user.password)
    end

    test "with invalid password returns error invalid_credentials" do
      user = user_fixture()

      assert {:error, :invalid_credentials} =
               Accounts.verify_user_credentials(user.username, "ERO!")
    end
  end
end
