defmodule CheetahApiWeb.Router do
  use CheetahApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CheetahApiWeb do
    pipe_through :api
  end
end
