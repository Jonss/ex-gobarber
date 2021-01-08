defmodule GobarberWeb.UsersController do
  use GobarberWeb, :controller

  alias GobarberWeb.Auth.Guardian

  action_fallback GobarberWeb.FallbackController

  def create(conn, params) do
    params
    |> Gobarber.create_user()
    |> handle_response(conn, :created, "created.json")
  end

  def authenticate(conn, params) do
    params
    |> Guardian.authenticate()
    |> handle_auth_response(conn)
  end

  def avatar(conn, %{"avatar" => avatar}) do
    email = conn.private.guardian_default_claims["sub"]

    Gobarber.create_avatar(avatar, email)
    |> handle_response(conn, :ok, "update.json")
  end

  defp handle_auth_response({:error, status_code}, _conn),
    do: {:error, %{response: "", status_code: status_code, view: "401.json"}}

  defp handle_auth_response({:ok, token}, conn) do
    conn
    |> put_status(:ok)
    |> render("sign_in.json", token: token)
  end

  defp handle_response({:ok, response}, conn, status_code, view) do
    {:ok, token, _claims} = Guardian.encode_and_sign(response)

    conn
    |> put_status(status_code)
    |> render(view, response: response, token: token)
  end

  defp handle_response({:error, changeset}, _conn, _status_code, _view),
    do: {:error, %{response: changeset, status_code: :bad_request, view: "400.json"}}
end
