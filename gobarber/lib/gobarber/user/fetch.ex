defmodule Gobarber.User.Fetch do
  alias Gobarber.Repo
  alias Gobarber.User

  def call(id), do: Repo.get(User, id)
end
