defmodule Backend.Router do
  use Backend.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :simple_auth do
    plug BasicAuth,
    realm: "Admin Area",
    username: "admin",
    password: System.get_env("ADMIN_SECRET")
  end

  scope "/api", Backend do
    pipe_through :api
    get "/user/:id", ApiController, :get_user
    post "/user/:id", ApiController, :update_score
    get "/ranking", ApiController, :ranking
    post "/register", ApiController, :register
  end

  scope "/", Backend do
    pipe_through :browser
    get "/", PageController, :index
    pipe_through :simple_auth
    resources "/users", UserController
  end
end
