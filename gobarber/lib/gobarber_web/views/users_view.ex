defmodule GobarberWeb.UsersView do
  use GobarberWeb, :view
  alias Gobarber.User

  def render("created.json", %{response: %User{id: id, email: email, inserted_at: inserted_at}}) do
    %{
      id: id,
      email: email,
      created_at: inserted_at
    }
  end
end
