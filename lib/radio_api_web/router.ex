defmodule RadioApiWeb.Router do
  use RadioApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {RadioApiWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :xml do
    plug :accepts, ["xml"]
    plug RadioApiWeb.Plugs.CustomHeaders
  end

  scope "/", RadioApiWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/", RadioApiWeb do
    pipe_through :xml

    # Login endpoint
    get "/setupapp/:model/asp/BrowseXML/loginXML.asp", RadioController, :login
    get "/setupapp/:model/asp/BrowseXML/Search.asp", RadioController, :search
    get "/podcasts", RadioController, :podcasts
    get "/stations", RadioController, :stations
    get "/radio-browser", RadioController, :radio_browser
    get "/vtuner/play/station=:station", RadioController, :any
    get "/*path", RadioController, :any
  end

  # Other scopes may use custom stacks.
  # scope "/api", RadioApiWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:radio_api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: RadioApiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
