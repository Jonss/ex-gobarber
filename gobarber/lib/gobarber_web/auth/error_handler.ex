defmodule GobarberWeb.Auth.ErrorHandler do
  import Plug.Conn

  @behaviour Guardian.Plug.ErrorHandler

  @spec auth_error(Plug.Conn.t(), {any, any}, any) :: Plug.Conn.t()
  def auth_error(conn, {type, reason}, _opts) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, Jason.encode!(%{message: to_string(type)}))
  end
end
