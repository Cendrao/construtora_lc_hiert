defmodule ConstrutoraLcHiert.Account.UsersTest do
  use ConstrutoraLcHiert.DataCase
  use ConstrutoraLcHiert.Fixtures, [:user]

  alias Comeonin.Bcrypt
  alias ConstrutoraLcHiert.Account.Users
  alias ConstrutoraLcHiert.Account.Users.User

  describe "list_users/0" do
    test "returns all users" do
      user = user_fixture()

      assert Users.list_users() == [user]
    end

    test "does not return soft deleted users" do
      user = user_fixture(%{deleted_at: NaiveDateTime.utc_now()})

      refute Users.list_users() == [user]
    end
  end

  describe "get_user!/1" do
    test "returns the user with given id" do
      user = user_fixture()

      assert Users.get_user!(user.id) == user
    end
  end

  describe "get_active_user_by_username/1" do
    test "returns the active user with the given username" do
      user = user_fixture(%{deleted_at: nil, username: "biridin"})

      assert Users.get_active_user_by_username("biridin") == user
    end
  end

  describe "create_user/1" do
    test "with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create_user(@valid_user_attrs)
      assert Bcrypt.checkpw("rusbé", user.password)
      assert user.username == "biridin"
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{} = changeset} = Users.create_user(@invalid_user_attrs)
      assert %{username: ["can't be blank"], password: ["can't be blank"]} = errors_on(changeset)
    end

    test "with invalid password_confirmation returns error changeset" do
      attrs = %{username: "maico", password: "rusbé", password_confirmation: "biridin"}

      assert {:error, %Ecto.Changeset{} = changeset} = Users.create_user(attrs)
      assert %{password_confirmation: ["does not match confirmation"]} = errors_on(changeset)
    end

    test "with invalid password length returns error changeset" do
      attrs = %{username: "maico", password: "oq?", password_confirmation: "oq?"}

      assert {:error, %Ecto.Changeset{} = changeset} = Users.create_user(attrs)
      assert %{password: ["should be at least 5 character(s)"]} = errors_on(changeset)
    end
  end

  describe "update_user/2" do
    test "with valid data updates the user" do
      user = user_fixture()

      assert {:ok, %User{} = user} = Users.update_user(user, @update_user_attrs)
      assert Bcrypt.checkpw("rusbé_updated", user.password)
      assert user.username == "biridin_updated"
    end

    test "with invalid data returns error changeset" do
      user = user_fixture()

      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_user_attrs)
      assert user == Users.get_user!(user.id)
    end
  end

  describe "soft_delete_user/1" do
    test "deletes the user" do
      user = user_fixture()

      assert {:ok, %User{}} = Users.soft_delete_user(user)
      refute Users.get_user!(user.id).deleted_at == nil
    end
  end

  describe "change_user/1" do
    test "returns a user changeset" do
      user = user_fixture()

      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
