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
    has_many :appointments, Appointment, foreign_key: :provider_id

    timestamps()
  end

  def build(params) do
    params
    |> changeset()
    |> handle_changeset()
  end

  def changeset(params), do: create_changeset(%__MODULE__{}, params)
  def changeset(user, params), do: create_changeset(user, params)

  @required_fields [:name, :email, :password]

  def create_changeset(struct, params) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: false} = changeset), do: changeset

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, Argon2.add_hash(password))
  end

  defp handle_changeset(%Ecto.Changeset{valid?: true} = changeset), do: {:ok, changeset}
  defp handle_changeset(%Ecto.Changeset{valid?: false} = changeset), do: {:error, changeset}
end
