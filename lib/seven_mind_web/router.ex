defmodule SevenMindWeb.Router do
  use SevenMindWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {SevenMindWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SevenMindWeb do
    pipe_through :browser

    get "/", Public.Web.PageController, :home
  end

  # Other scopes may use custom stacks.
  scope "/api/content-manager" do
    pipe_through :api

    forward "/swaggerui",
      SevenMindWeb.ContentManager.Setup.SwaggerUi,
      path: "/api/content-manager/open_api",
      title: "Content Manager JSON-API - Swagger UI",
      default_model_expand_depth: 4

    forward "/redoc",
      SevenMindWeb.ContentManager.Setup.Redoc,
      spec_url: "/api/content-manager/open_api"

    forward "/", SevenMindWeb.ContentManager.Setup.Router
  end

  scope "/api/meditator" do
    pipe_through :api

    forward "/swaggerui",
      SevenMindWeb.Meditator.Setup.SwaggerUi,
      path: "/api/meditator/open_api",
      title: "Meditator JSON-API - Swagger UI",
      default_model_expand_depth: 4

    forward "/redoc",
      SevenMindWeb.Meditator.Setup.Redoc,
      spec_url: "/api/meditator/open_api"

    forward "/", SevenMindWeb.Meditator.Setup.Router
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:seven_mind, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: SevenMindWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
