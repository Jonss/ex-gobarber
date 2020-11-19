defmodule Gobarber.AppointmentTest do
  use Gobarber.DataCase

  alias Gobarber.Appointment

  describe "changeset/1" do
    test "when all params are valid, should return a valid changeset with normalized hour" do
      params = %{provider: "Jupiter Stein", date: "2020-11-18 19:30:00"}

      changeset = Appointment.changeset(params)

      assert %Ecto.Changeset{
               changes: %{
                 provider: "Jupiter Stein",
                 date: ~U[2020-11-18 19:00:00Z]
               },
               errors: [],
               data: %Gobarber.Appointment{},
               valid?: true
             } = changeset
    end

    test "when date is invalid, should return an error" do
      params = %{provider: "Jupiter Stein", date: "2020-11-18"}

      changeset = Appointment.changeset(params)

      assert %Ecto.Changeset{
               changes: %{provider: "Jupiter Stein"},
               errors: [
                 date: {
                   "is invalid",
                   [type: :utc_datetime, validation: :cast]
                 }
               ],
               data: %Gobarber.Appointment{},
               valid?: false
             } = changeset
    end

    test "when provider is empty, should return an error" do
      params = %{provider: "", date: "2020-11-18 20:00:00"}

      changeset = Appointment.changeset(params)

      assert %Ecto.Changeset{
               changes: %{date: ~U[2020-11-18 20:00:00Z]},
               errors: [provider: {"can't be blank", [validation: :required]}],
               data: %Gobarber.Appointment{},
               valid?: false
             } = changeset
    end

    test "when provider and date is empty, should return an error" do
      params = %{provider: "", date: ""}

      changeset = Appointment.changeset(params)

      assert %Ecto.Changeset{
               changes: %{},
               errors: [
                 {:provider, {"can't be blank", [validation: :required]}},
                 {:date, {"can't be blank", [validation: :required]}}
               ],
               data: %Gobarber.Appointment{},
               valid?: false
             } = changeset
    end
  end

  describe "build/1" do
    test "when params is valid should return a valid {:ok, appointment}" do
      params = %{provider: "Jupiter Stein", date: "2020-11-18 19:30:00"}

      appointment = Appointment.build(params)

      assert {:ok,
              %Gobarber.Appointment{
                date: ~U[2020-11-18 19:00:00Z],
                id: nil,
                inserted_at: nil,
                provider: "Jupiter Stein",
                updated_at: nil
              }} = appointment
    end

    test "when provider is empty should return an :error" do
      params = %{provider: "", date: "2020-11-18 18:00:00"}

      changeset = Appointment.build(params)

      assert {:error, %Ecto.Changeset{
        action: :insert,
        changes: %{date: ~U[2020-11-18 18:00:00Z]},
         errors: [provider: {"can't be blank", [validation: :required]}],
        valid?: false}}
       = changeset
    end

    test "when date is invalid should return an :error" do
      params = %{provider: "Jupiter Stein", date: "2020-11-18"}

      changeset = Appointment.build(params)

      assert {:error,
        %Ecto.Changeset{
          action: :insert,
          changes: %{provider: "Jupiter Stein"},
          errors: [date: {"is invalid",  [type: :utc_datetime, validation: :cast]}],
          valid?: false
        }
      } = changeset
    end

    test "when date and provider are empty should return an :error" do
      params = %{provider: "", date: ""}

      changeset = Appointment.build(params)

      assert {:error,
        %Ecto.Changeset{
          action: :insert,
          changes: %{},
          errors: [provider: {"can't be blank", [validation: :required]}, date: {"can't be blank", [validation: :required]}],
          valid?: false
        }
      } = changeset
    end

  end
end
