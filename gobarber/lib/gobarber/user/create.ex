defmodule Gobarber.User.Create do
  alias Gobarber.Repo
  alias Gobarber.User

  def call(params) do
    params
    |> User.build()
    |> handle_create()
  end

  defp handle_create({:ok, changeset}) do
    Repo.insert(changeset)
  end

  defp handle_create({:error, changeset}), do: {:error, changeset}
end
