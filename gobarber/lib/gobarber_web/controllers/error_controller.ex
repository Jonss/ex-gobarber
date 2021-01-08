defmodule GobarberWeb.ErrorController do
  use GobarberWeb, :controller

  def notfound(conn, _params) do
    conn
    |> put_status(:ok)
    |> render("hello.json")
  end

end
