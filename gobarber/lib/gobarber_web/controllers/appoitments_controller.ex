defmodule GobarberWeb.AppointmentsController do
  use GobarberWeb, :controller

  action_fallback GobarberWeb.FallbackController

  def create(conn, params) do
    params
    |> Gobarber.create_appointment()
    |> handle_response(conn, :created, "created.json")
  end

  defp handle_response({:ok, appointment}, conn, status_code, view) do
    conn
    |> put_status(status_code)
    |> render(view, appointment: appointment)
  end

  defp handle_response({:error, changeset} = error, _conn, _status_code, _view),
    do: {:error, %{changeset: changeset, status_code: :bad_request, view: "400.json"}}
end
