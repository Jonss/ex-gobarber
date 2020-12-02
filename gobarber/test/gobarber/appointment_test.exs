defmodule Gobarber.AppointmentTest do
  use Gobarber.DataCase
  alias Gobarber.Appointment
  alias Gobarber.User.Create, as: CreateUser

  setup do
    {:ok, user} =
      CreateUser.call(%{
        name: "Jupiter Stein",
        email: "jupiter.stein@gmail.com",
        password: "123456"
      })

    {:ok, user: user}
  end

  describe "changeset/1" do
    test "when all params are valid, should return a valid changeset with normalized hour", %{
      user: user
    } do
      params = %{provider_id: user.id, date: "2020-11-18 19:30:00"}

      changeset = Appointment.changeset(params)

      assert %Ecto.Changeset{
               changes: %{
                 provider_id: _provider_id,
                 date: ~U[2020-11-18 19:00:00Z]
               },
               errors: [],
               data: %Gobarber.Appointment{},
               valid?: true
             } = changeset
    end

    test "when date is invalid, should return an error", %{user: user} do
      params = %{provider_id: user.id, date: "2020-11-18"}

      changeset = Appointment.changeset(params)

      assert %Ecto.Changeset{
               changes: %{provider_id: _provider_id},
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
               errors: [provider_id: {"can't be blank", [validation: :required]}],
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
                 date: {"can't be blank", [validation: :required]},
                 provider_id: {"can't be blank", [validation: :required]}
               ],
               data: %Gobarber.Appointment{},
               valid?: false
             } = changeset
    end
  end

  describe "build/1" do
    test "when params is valid should return a valid {:ok, appointment}", %{user: user} do
      params = %{provider_id: user.id, date: "2020-11-18 19:30:00"}

      appointment = Appointment.build(params)

      assert {:ok,
              %Gobarber.Appointment{
                date: ~U[2020-11-18 19:00:00Z],
                id: nil,
                inserted_at: nil,
                provider_id: _provider_id,
                updated_at: nil
              }} = appointment
    end

    test "when provider is empty should return an :error" do
      params = %{provider_id: "", date: "2020-11-18 18:00:00"}

      changeset = Appointment.build(params)

      assert {:error,
              %Ecto.Changeset{
                action: :insert,
                changes: %{date: ~U[2020-11-18 18:00:00Z]},
                errors: [provider_id: {"can't be blank", [validation: :required]}],
                valid?: false
              }} = changeset
    end

    test "when date is invalid should return an :error", %{user: user} do
      params = %{provider_id: user.id, date: "2020-11-18"}

      changeset = Appointment.build(params)

      assert {:error,
              %Ecto.Changeset{
                action: :insert,
                changes: %{provider_id: _provider_id},
                errors: [date: {"is invalid", [type: :utc_datetime, validation: :cast]}],
                valid?: false
              }} = changeset
    end

    test "when date and provider are empty should return an :error" do
      params = %{provider_id: "", date: ""}

      changeset = Appointment.build(params)

      assert {:error,
              %Ecto.Changeset{
                action: :insert,
                changes: %{},
                errors: [
                  date: {"can't be blank", [validation: :required]},
                  provider_id: {"can't be blank", [validation: :required]}
                ],
                valid?: false
              }} = changeset
    end
  end
end
