defmodule GobarberWeb.AppointmentsController do
  use GobarberWeb, :controller

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


end
