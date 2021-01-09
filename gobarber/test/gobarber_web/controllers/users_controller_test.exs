defmodule GobarberWeb.UsersControllerTest do
  use GobarberWeb.ConnCase
  alias Gobarber.User.Create, as: CreateUser
  import GobarberWeb.Auth.Guardian

  setup %{conn: conn} do
    {:ok, user} =
      CreateUser.call(%{
        name: "Jupiter Stein Authorized",
        email: "jupiter.stein_authorized@gmail.com",
        password: "123456"
      })

    {:ok, user_with_token} =
      CreateUser.call(%{
        name: "Jupiter Stein token",
        email: "jupiter.stein_token@gmail.com",
        password: "123456"
      })

    {:ok, token, _claims} = encode_and_sign(user_with_token)

    conn = put_req_header(conn, "authorization", "Bearer #{token}")

    {:ok, conn: conn, auth_user: user, user_with_token: user_with_token}
  end

  describe "create/2" do
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

  describe "authenticate/2" do
    test "should authenticate",%{conn: conn} do
      params = %{email: "jupiter.stein_authorized@gmail.com", password: "123456"}

      response =
        conn
        |> post(Routes.users_path(conn, :authenticate, params))
        |> json_response(:ok)

      assert %{
        "token" => _token,
        "type" => "Bearer"
        } = response
    end

    test "should not authenticate when user does not exists",%{conn: conn} do
      params = %{email: "i-dont-exist@gmail.com", password: "123456"}

      response =
        conn
        |> post(Routes.users_path(conn, :authenticate, params))
        |> json_response(:not_found)

      assert %{} = response
    end

    test "should not authenticate when user set a wrong password",%{conn: conn} do
      params = %{email: "jupiter.stein_authorized@gmail.com", password: "78910"}

      response =
        conn
        |> post(Routes.users_path(conn, :authenticate, params))
        |> json_response(:unauthorized)

      assert %{} == response
    end
  end

  describe "avatar/2" do
    test "should send an avatar image and get success", %{conn: conn} do
      avatar = %Plug.Upload{
        path: "test/fixtures/jupiter-avatar.jpeg",
        filename: "jupiter-avatar.jpeg"}

      response =
        conn
        |> put_req_header("content-type", "multipart/form-data")
        |> patch("/api/users/avatar", %{:avatar => avatar})
        |> json_response(:ok)

      assert %{
        "user" => %{
          "avatar" => "jupiter.stein_token@gmail.com-jupiter-avatar.jpeg",
          "created_at" => _created_at,
          "email" => "jupiter.stein_token@gmail.com",
          "id" => _id
        }
      } = response
    end

    test "should send an avatar image and get bad request", %{conn: conn} do
      avatar = %Plug.Upload{
        path: "test/fixtures/not-jupiter-avatar.jpeg",
        filename: "not-jupiter-avatar.jpeg"}

      response =
        conn
        |> put_req_header("content-type", "multipart/form-data")
        |> patch("/api/users/avatar", %{:avatar => avatar})
        |> json_response(:bad_request)

      assert %{"errors" => %{"detail" => "Bad Request"}} = response
    end
  end
end
