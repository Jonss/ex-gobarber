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

  def render("sign_in.json", %{token: token}) do
    %{
      token: "#{token}",
      type: "Bearer"
    }
  end

  def render("update.json", %{response: %User{id: id, email: email, inserted_at: inserted_at, avatar: avatar}}) do
    %{
      user: %{
        id: id,
        email: email,
        created_at: inserted_at,
        avatar: avatar,
      }
    }
  end

end
