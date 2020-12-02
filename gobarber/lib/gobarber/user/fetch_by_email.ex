defmodule Gobarber.User.FetchByEmail do
  alias Gobarber.{Repo, User}

  def call(email) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, "not found"}
      user -> {:ok, user}
    end
  end
end
