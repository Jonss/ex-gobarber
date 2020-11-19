defmodule GobarberWeb.FallbackController do
  use GobarberWeb, :controller

  def call(conn, {:error, params}) do
    conn
    |> put_status(params.status_code)
    |> put_view(GobarberWeb.ErrorView)
    |> render(params.view, result: params.changeset)
  end
end
