defmodule Gobarber.User.Avatar do
  alias Gobarber.Repo
  alias Gobarber.User

  def call(avatar, email) do
    file_name = "#{email}-#{avatar.filename}"
    path = "priv/static/tmp/#{file_name}"

    avatar.path
    |> File.cp(Path.absname(path))
    |> handle_file(file_name, email)
  end

  defp handle_file(:ok, file_name, email) do
    case Gobarber.fetch_user_by_email(email) do
      {:ok, user} ->
        changeset = User.update_changeset(user, %{avatar: file_name})
        {:ok, Repo.update!(changeset)}
      {:error, _message} -> {:error, "image invalid"}
    end
  end

  defp handle_file({:error, :enoent}, _path, _email) do
    {:error, "image invalid"}
  end



end
