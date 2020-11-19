defmodule GobarberWeb.AppointmentsView do
  use GobarberWeb, :view
  alias Gobarber.Appointment

  def render("created.json", %{response: %Appointment{id: id, provider: provider, date: date}}) do
    %{
      id: id,
      provider: provider,
      date: date
    }
  end

  def render("list.json", %{response: response}) do
    %{
      appointments:
        Enum.map(response, fn r ->
          %{
            id: r.id,
            provider: r.provider,
            date: r.date
          }
        end)
    }
  end
end
