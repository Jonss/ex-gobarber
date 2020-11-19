defmodule Gobarber.Appointment.Create do
  alias Gobarber.Repo
  alias Gobarber.Appointment

  def call(params) do
    params
    |> Appointment.build()
    |> create_appointment()
  end

  defp create_appointment({:ok, struct}) do
    case Repo.get_by(Appointment, date: struct.date, provider: struct.provider) do
      nil ->
        Repo.insert(struct)

      _appointment ->
        {:unprocessable, "provider #{struct.provider} is already booked at #{struct.date}"}
    end
  end

  defp create_appointment({:error, _changeset} = error), do: error
end
