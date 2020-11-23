defmodule Gobarber.Appointment.CreateTest do
  use Gobarber.DataCase
  alias Gobarber.Appointment.Create
  alias Gobarber.User.Create, as: CreateUser

  describe "call/1" do
    setup do
      {:ok, user} =
        CreateUser.call(%{
          name: "Jupiter Stein",
          email: "jupiter.stein@gmail.com",
          password: "123456"
        })

      {:ok, user: user}
    end

    test "when params is valid should persist an appointment", %{user: user} do
      params = %{provider_id: user.id, date: "2020-11-19 19:32:00"}

      appointment = Create.call(params)

      assert {:ok,
              %Gobarber.Appointment{
                date: ~U[2020-11-19 19:00:00Z],
                id: _id,
                provider_id: _provider,
                inserted_at: _inserted_at,
                updated_at: _updated_at
              }} = appointment
    end

    test "when params are invalid should return a changeset with error" do
      params = %{provider_id: "", date: ""}

      changeset = Create.call(params)

      assert {
        :error,
        %Ecto.Changeset{
          action: :insert,
          changes: %{},
          constraints: [
            %{
              constraint: "appointments_provider_id_fkey",
              error_message: "does not exist",
              error_type: :foreign,
              field: :provider_id,
              match: :exact,
              type: :foreign_key
            }
          ],
          data: %Gobarber.Appointment{
            date: nil,
            id: nil,
            inserted_at: nil,
            provider: _provider_not_associated,
            provider_id: nil,
            updated_at: nil
          },
          empty_values: [""],
          errors: [date: {"can't be blank", [validation: :required]}, provider_id: {"can't be blank", [validation: :required]}],
          filters: %{},
          params: %{"date" => "", "provider_id" => ""},
          prepare: [],
          repo: nil,
          repo_opts: [],
          required: [:date, :provider_id],
          types: %{
            date: :utc_datetime,
            id: :binary_id,
            inserted_at: :naive_datetime,
            provider: {
              :assoc,
              %Ecto.Association.BelongsTo{
                cardinality: :one,
                defaults: [],
                field: :provider,
                on_cast: nil,
                on_replace: :raise,
                ordered: false,
                owner: Gobarber.Appointment,
                owner_key: :provider_id,
                queryable: Gobarber.User,
                related: Gobarber.User,
                related_key: :id,
                relationship: :parent,
                unique: true,
                where: []
              }
            },
            provider_id: Ecto.UUID,
            updated_at: :naive_datetime
          },
          valid?: false,
          validations: []
        }
      } = changeset
    end

    test "when appointment already exists should return :unprocessable", %{user: user} do
      params = %{provider_id: user.id, date: "2020-11-19 19:32:00"}

      Create.call(params)

      unprocessable_appointment = Create.call(params)

      assert {:unprocessable, "provider Jupiter Stein is already booked at 2020-11-19 19:00:00Z"} ==
               unprocessable_appointment
    end
  end
end
