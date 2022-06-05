defmodule PopovChatWeb.Router do
  use PopovChatWeb, :router
  import PopovChatWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_current_user
  end

  scope "/", PopovChatWeb do
    pipe_through :api

    get "/", RootController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", PopovChatWeb do
    pipe_through :api

    post "/token", TokenController, :login
    delete "/token", TokenController, :delete
  
  end

   scope "/api/user", PopovChatWeb do
     pipe_through :api
     post "/register", UserController, :create
   end

  scope "/api/group", PopovChatWeb do
    pipe_through [:api, :require_authenticated_user]
    post "/", GroupController, :create
    get "/", GroupController, :list
    get "/search", GroupController, :list_not_joined
    post "/:group_id", GroupController, :join
    get "/:group_id", GroupController, :details
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
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PopovChatWeb.Telemetry
    end
  end

  ## Authentication routes

  scope "/", PopovChatWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

  end

  scope "/", PopovChatWeb do
    pipe_through [:browser, :require_authenticated_user]
  end

  scope "/", PopovChatWeb do
    pipe_through [:browser]
  end
end
