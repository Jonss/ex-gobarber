defmodule GobarberWeb.UsersController do
  use GobarberWeb, :controller

  action_fallback GobarberWeb.FallbackController

  def create(conn, params) do
    params
    |> Gobarber.create_user()
    |> handle_response(conn, :created, "created.json")
  end

  defp handle_response({:ok, response}, conn, status_code, view) do
    conn
    |> put_status(status_code)
    |> render(view, response: response)
  end

  defp handle_response({:error, changeset}, _conn, _status_code, _view),
    do: {:error, %{response: changeset, status_code: :bad_request, view: "400.json"}}
end
