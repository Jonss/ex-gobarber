defmodule Gobarber.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Gobarber.Appointment

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "users" do
    field :name, :string
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    has_many :appointments, Appointment

    timestamps()
  end

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params), do: create_changeset(%__MODULE__{}, params)
  def changeset(user, params), do: create_changeset(user, params)

  @required_fields [:name, :email, :password]

  def create_changeset(struct, params) do
    struct
    |> cast(params, @required_fields)
    |> unique_constraint(:email, name: "users_email_index")
    |> validate_required(@required_fields)
    |> validate_length(:password, min: 6)
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, Argon2.add_hash(password))
  end
end
