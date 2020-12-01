defmodule Gobarber.User.CreateTest do
  use Gobarber.DataCase

  alias Gobarber.User.Create, as: CreateUser

  describe "call/1" do
    test "when user is created and try to create again with same email should return a tuple with error and changeset" do
      params = %{name: "Jupiter Stein", email: "jupiter.stein@gmail.com", password: "123456"}

      CreateUser.call(params)
      response = CreateUser.call(params)

      assert {
               :error,
               %Ecto.Changeset{
                 changes: %{
                   email: "jupiter.stein@gmail.com",
                   name: "Jupiter Stein",
                   password: "123456",
                   password_hash: _password_hash
                 },
                 action: :insert,
                 constraints: [
                   %{
                     constraint: "users_email_index",
                     error_message: "has already been taken",
                     error_type: :unique,
                     field: :email,
                     match: :exact,
                     type: :unique
                   }
                 ],
                 data: %Gobarber.User{},
                 empty_values: [""],
                 errors: [
                   email:
                     {"has already been taken",
                      [constraint: :unique, constraint_name: "users_email_index"]}
                 ],
                 filters: %{},
                 params: %{
                   "email" => "jupiter.stein@gmail.com",
                   "name" => "Jupiter Stein",
                   "password" => "123456"
                 },
                 prepare: [],
                 repo: Gobarber.Repo,
                 repo_opts: [],
                 required: [:name, :email, :password],
                 types: %{
                   appointments:
                     {:assoc,
                      %Ecto.Association.Has{
                        cardinality: :many,
                        defaults: [],
                        field: :appointments,
                        on_cast: nil,
                        on_delete: :nothing,
                        on_replace: :raise,
                        ordered: false,
                        owner: Gobarber.User,
                        owner_key: :id,
                        queryable: Gobarber.Appointment,
                        related: Gobarber.Appointment,
                        related_key: :provider_id,
                        relationship: :child,
                        unique: true,
                        where: []
                      }},
                   email: :string,
                   id: :binary_id,
                   inserted_at: :naive_datetime,
                   name: :string,
                   password: :string,
                   password_hash: :string,
                   updated_at: :naive_datetime
                 },
                 valid?: false,
                 validations: [{:email, {:format, ~r/@/}}]
               }
             } = response
    end
  end
end
