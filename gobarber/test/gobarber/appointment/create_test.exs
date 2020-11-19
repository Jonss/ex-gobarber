defmodule Gobarber.Appointment.CreateTest do
  use Gobarber.DataCase
  alias Gobarber.Appointment.Create

  describe "call/1" do
    test "when params is valid should persist an appointment" do
      params = %{provider: "Jupiter Stein", date: "2020-11-19 19:32:00"}

      appointment = Create.call(params)

      assert {:ok,
        %Gobarber.Appointment{
          date: ~U[2020-11-19 19:00:00Z],
          id: _id,
          provider: "Jupiter Stein",
          inserted_at: _inserted_at,
          updated_at: _updated_at
        }
      } = appointment
    end

    test "when params are invalid should return a changeset with error" do
      params = %{provider: "", date: ""}

      changeset = Create.call(params)

      assert {:error,
       %Ecto.Changeset{
        action: :insert, changes: %{},
        errors: [provider: {"can't be blank", [validation: :required]}, date: {"can't be blank", [validation: :required]}],
         params: %{"date" => "", "provider" => ""},
         data: %Gobarber.Appointment{}, valid?: false,
          required: [:provider, :date],
                types: %{date: :utc_datetime, id: :binary_id, inserted_at: :naive_datetime, provider: :string, updated_at: :naive_datetime}
         }
      } == changeset

    end

    test "when appointment already exists should return :unprocessable" do
      params = %{provider: "Jupiter Stein", date: "2020-11-19 19:32:00"}

      Create.call(params)

      unprocessable_appointment = Create.call(params)

      assert {:unprocessable, "provider Jupiter Stein is already booked at 2020-11-19 19:00:00Z"} == unprocessable_appointment
    end
  end
end
