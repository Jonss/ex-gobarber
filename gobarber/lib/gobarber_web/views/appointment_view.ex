defmodule GobarberWeb.AppointmentsView do
  use GobarberWeb, :view
  alias Gobarber.Appointment

  def render("created.json", %{appointment: %Appointment{id: id, provider: provider, date: date}}) do
    %{
      id: id,
      provider: provider,
      date: date
    }
  end
end
