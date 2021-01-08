defmodule GobarberWeb.Router do
  use GobarberWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug GobarberWeb.Auth.Pipeline
  end

  pipeline :static do
    plug Plug.Static,
      at: "/files",
      from: {:gobarber, "priv/static/tmp"}
  end

  scope "/", GobarberWeb do
    scope "/files" do
      pipe_through :static
      get "/*path", ErrorController, :notfound
    end
  end

  scope "/api", GobarberWeb do
    pipe_through :api

    get "/hello", HelloController, :hello
    post "/users/auth", UsersController, :authenticate
    post "/users", UsersController, :create
  end

  scope "/api", GobarberWeb do
    pipe_through [:api, :auth]

    resources "/appointments", AppointmentsController, only: [:create, :index]
    patch "/users/avatar", UsersController, :avatar
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: GobarberWeb.Telemetry
    end
  end
end
