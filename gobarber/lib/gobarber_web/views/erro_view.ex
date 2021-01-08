defmodule GobarberWeb.ErrorView do
  use GobarberWeb, :view

  def render("hello.json", %{}) do
    %{
      message: "Hello Mundo!"
    }
  end
end
