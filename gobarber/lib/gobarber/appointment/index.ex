defmodule Gobarber.Appointment.Index do
  alias Gobarber.Repo
  alias Gobarber.Appointment

  def call(), do: Repo.all(Appointment) |> Repo.preload([:provider])
end
