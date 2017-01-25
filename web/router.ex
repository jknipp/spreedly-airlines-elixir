defmodule SpreedlyAirlinesElixir.Router do
  use SpreedlyAirlinesElixir.Web, :router

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

  scope "/", SpreedlyAirlinesElixir do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/transactions", TransactionController, :index
    get "/transactions/:token", TransactionController, :show

    scope "/flights" do 
      get "/", FlightController, :index
      get "/:id", FlightController, :show
      post "/purchase", FlightController, :purchase
      get "/purchase/confirmation", FlightController, :confirmation
    end 
end

  # Other scopes may use custom stacks.
  # scope "/api", SpreedlyAirlinesElixir do
  #   pipe_through :api
  # end
end
