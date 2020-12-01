defmodule GobarberWeb.UsersView do
  use GobarberWeb, :view
  alias Gobarber.User

  def render("created.json", %{
      response: %User{id: id, email: email, inserted_at: inserted_at},
      token: token
  }) do
    %{
      user: %{
        id: id,
        email: email,
        created_at: inserted_at
      },
      token: token
    }
  end

  def render("sign_in.json", params) do
    %{
      token: "Bearer #{params.token}"
    }
  end


end
