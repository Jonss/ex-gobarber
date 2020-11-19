defmodule GobarberWeb.FallbackController do
  use GobarberWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(result.status_code)
    |> put_view(GobarberWeb.ErrorView)
    |> render(result.view, result: result.changeset)
  end
end
