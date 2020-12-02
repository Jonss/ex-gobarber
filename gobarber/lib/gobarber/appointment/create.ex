defmodule Gobarber.Appointment.Create do
  alias Gobarber.Repo
  alias Gobarber.Appointment

  def call(params) do
    params
    |> Appointment.build()
    |> create_appointment()
  end

  defp create_appointment({:ok, struct}) do
    appointment =
      Repo.get_by(Appointment, date: struct.date, provider_id: struct.provider_id)
      |> Repo.preload([:provider])

    case appointment do
      nil ->
        {:ok, Repo.insert!(struct) |> Repo.preload([:provider])}

      appointment ->
        {:unprocessable,
         "provider #{appointment.provider.name} is already booked at #{struct.date}"}
    end
  end

  defp create_appointment({:error, _changeset} = error), do: error
end
