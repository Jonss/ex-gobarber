defmodule Gobarber do
  @moduledoc """
  Gobarber keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Gobarber.{Appointment, User}

  defdelegate create_appointment(params), to: Appointment.Create, as: :call
  defdelegate fetch_appointments, to: Appointment.Index, as: :call
  defdelegate create_user(params), to: User.Create, as: :call
end
