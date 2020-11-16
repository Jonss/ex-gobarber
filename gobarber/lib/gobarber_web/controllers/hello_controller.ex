defmodule GobarberWeb.HelloController do
  use GobarberWeb, :controller

  def hello(conn, _params) do
    conn
    |> put_status(:ok)
    |> render("hello.json")
  end
end
