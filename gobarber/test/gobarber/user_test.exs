defmodule Gobarber.UserTest do
  use Gobarber.DataCase

  alias Gobarber.User

  describe "build/1" do
    test "when user does not exist should persist" do
      params = %{name: "Jupiter Stein", email: "jupiter.stein@gmail.com", password: "123456"}

      result = User.build(params)

      assert {
               :ok,
               %Ecto.Changeset{
                 action: nil,
                 changes: %{
                   email: "jupiter.stein@gmail.com",
                   name: "Jupiter Stein",
                   password: "123456",
                   password_hash: _password_hash
                 },
                 errors: [],
                 data: %Gobarber.User{},
                 valid?: true
               }
             } = result
    end
  end
end
