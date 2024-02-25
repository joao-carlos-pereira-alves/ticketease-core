defmodule ReservaOnlineWeb.Router do
  use ReservaOnlineWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug ReservaOnlineWeb.Plugs.Locale, "pt_BR"
  end

  pipeline :auth do
    plug ReservaOnlineWeb.Plugs.Auth
  end

  scope "/api/v1", ReservaOnlineWeb do
    pipe_through :api

    resources "/sign_up", UsersController, only: [:create]
    post "/sign_in", UsersController, :login
  end

  scope "/api/v1", ReservaOnlineWeb do
    pipe_through [:api, :auth]

    resources "/users", UsersController, only: [:update, :delete, :show]
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:reserva_online, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: ReservaOnlineWeb.Telemetry
    end
  end
end
