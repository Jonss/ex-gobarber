defmodule Gobarber.Repo do
  use Ecto.Repo,
    otp_app: :gobarber,
    adapter: Ecto.Adapters.Postgres
end
