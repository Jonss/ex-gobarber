defmodule Gobarber.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false
      add :email, :string, null: false
      add :password_hash, :string, null: false

      timestamps()
    end

    create unique_index(:users, [:email])

    alter table(:appointments) do
      add :provider_id, references(:users, type: :uuid, on_delete: :nilify_all)
      remove :provider
    end
  end
end
