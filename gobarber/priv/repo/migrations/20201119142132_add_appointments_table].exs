defmodule :"Elixir.Gobarber.Repo.Migrations.AddAppointmentsTable]" do
  use Ecto.Migration

  def change do
    create table(:appointments, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :provider, :string, null: false
      add :date, :utc_datetime

      timestamps()
    end
  end
end
