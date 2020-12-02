defmodule Gobarber.User.FetchTest do
  use Gobarber.DataCase

  alias Gobarber.User.Fetch, as: FetchUser
  alias Gobarber.User.Create, as: CreateUser

  describe "call/1" do
    test "when user exists, should get this user" do
      params = %{name: "Jupiter Stein", email: "jupiter.stein@gmail.com", password: "123456"}

      {:ok, %Gobarber.User{id: user_id, email: email}} = CreateUser.call(params)

      assert "jupiter.stein@gmail.com" == email

      user = FetchUser.call(user_id)

      assert %Gobarber.User{
               email: "jupiter.stein@gmail.com",
               id: _id,
               inserted_at: _inserted_at,
               name: "Jupiter Stein",
               password: nil,
               password_hash: _hash,
               updated_at: _updated_at
             } = user
    end

    test "when user does not exists, should return nil" do
      user = FetchUser.call("0669efc8-1fec-429b-b52f-a82726f6da7a")

      assert nil == user
    end
  end
end
