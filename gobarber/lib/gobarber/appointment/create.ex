defmodule Gobarber.Appointment.Create do
  alias Gobarber.Repo
  alias Gobarber.Appointment

  def call(params) do
    params
    |> Appointment.build()
    |> create_appointment()
  end

  defp create_appointment({:ok, struct}), do: Repo.insert(struct)
  defp create_appointment({:error, _changeset} = error), do: error

end
