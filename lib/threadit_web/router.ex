defmodule ThreaditWeb.Router do
  use ThreaditWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ThreaditWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Inertia.Plug
  end

  pipeline :ensure_authenticated do
    plug ThreaditWeb.EnsureAuthenticated
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Public routes
  scope "/", ThreaditWeb do
    pipe_through :browser

    get "/login", AuthController, :login_page
    post "/login", AuthController, :login
    post "/logout", AuthController, :logout
  end

  # Authenticated routes
  scope "/", ThreaditWeb do
    pipe_through [:browser, :ensure_authenticated]

    get "/", FeedController, :feed
  end
end
