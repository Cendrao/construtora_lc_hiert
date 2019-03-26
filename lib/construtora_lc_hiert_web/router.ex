defmodule ConstrutoraLcHiertWeb.Router do
  use ConstrutoraLcHiertWeb, :router

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

  pipeline :auth do
    plug ConstrutoraLcHiert.Authentication.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
    plug :put_layout, {ConstrutoraLcHiertWeb.LayoutView, :admin}
  end

  scope "/", ConstrutoraLcHiertWeb do
    pipe_through [:browser, :auth]

    get "/", HomeController, :index
    get "/quem-somos", AboutController, :index

    post "/contato", ContactController, :create

    post "/subscriber", SubscriberController, :create

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
  end

  scope "/admin", ConstrutoraLcHiertWeb, as: :admin do
    pipe_through [:browser, :auth, :ensure_auth]

    get "/", Admin.PageController, :index
  end

  if Mix.env() == :dev do
    forward "/sent_emails", Bamboo.SentEmailViewerPlug
  end
end
