defmodule Gobarber.UserTest do
  use Gobarber.DataCase

  alias Gobarber.User

  describe "build/1" do
    test "when user does not exist should persist" do
      params = %{name: "Jupiter Stein", email: "jupiter.stein@gmail.com", password: "123456"}

      result = User.build(params)

      assert {:ok,
              %Gobarber.User{
                email: "jupiter.stein@gmail.com",
                id: nil,
                inserted_at: nil,
                name: "Jupiter Stein",
                password: "123456",
                password_hash: _password,
                updated_at: nil
              }} = result
    end

    test "when user already exists should return a changeset with error" do
      params = %{name: "Jupiter Stein", email: "jupiter.stein@gmail.com", password: "123456"}

      User.Create.call(params)
      result = User.Create.call(params)

      assert "yey" = result
    end
  end
end
