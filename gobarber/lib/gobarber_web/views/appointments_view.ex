defmodule GobarberWeb.AppointmentsView do
  use GobarberWeb, :view
  alias Gobarber.Appointment
  alias Gobarber.User

  def render("created.json", %{
        response: %Appointment{id: id, provider: %User{name: name}, date: date}
      }) do
    %{
      id: id,
      provider: name,
      date: date
    }
  end

  def render("list.json", %{response: response}) do
    %{
      appointments:
        Enum.map(response, fn r ->
          %{
            id: r.id,
            provider: r.provider.name,
            date: r.date
          }
        end)
    }
  end
end
