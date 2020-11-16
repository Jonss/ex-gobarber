defmodule GobarberWeb.HelloView do
  use GobarberWeb, :view

  def render("hello.json", %{}) do
    %{
      message: "Hello Mundo!"
    }
  end
end
