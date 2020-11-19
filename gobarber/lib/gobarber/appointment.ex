defmodule Gobarber.Appointment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "appointments" do
    field :provider, :string
    field :date, :utc_datetime
    timestamps()
  end

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  @required_params [:provider, :date]

  def changeset(params), do: create_changeset(%__MODULE__{}, params)
  def changeset(appointment, params), do: create_changeset(appointment, params)

  defp create_changeset(struct, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end
end
