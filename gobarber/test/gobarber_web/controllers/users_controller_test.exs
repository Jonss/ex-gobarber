defmodule GobarberWeb.UsersControllerTest do
  use GobarberWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: conn}
  end

  describe "new/2" do
    test "when params are valid, should create user", %{conn: conn} do
      params = %{name: "Jupiter Stein", email: "jupiter.stein@gmail.com", password: "123456"}

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "token" => _token,
               "user" => %{
                 "id" => _id,
                 "email" => "jupiter.stein@gmail.com",
                 "created_at" => _created_at
               }
             } = response
    end

    test "when email are invalid should return an error", %{conn: conn} do
      params = %{name: "Jupiter Stein", email: "jupiter.steingmail.com", password: "123456"}

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{"message" => %{"email" => ["has invalid format"]}} == response
    end

    test "when user is already registered should return an error", %{conn: conn} do
      params = %{name: "Jupiter Stein", email: "jupiter.stein@gmail.com", password: "123456"}

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "token" => _token,
               "user" => %{
                 "id" => _id,
                 "email" => "jupiter.stein@gmail.com",
                 "created_at" => _created_at
               }
             } = response

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{"message" => %{"email" => ["has already been taken"]}} == response
    end
  end
end
