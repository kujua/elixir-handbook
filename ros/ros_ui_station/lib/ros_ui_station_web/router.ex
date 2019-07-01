defmodule Ros.StationWeb.Router do
  use Ros.StationWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_for_worker
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Ros.StationWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Ros.StationWeb do
  #   pipe_through :api
  # end

  defp put_for_worker(conn, _) do
    for_worker = "Station:" <> Ros.StationWeb.Endpoint.config(:station_number, "1")
    assign(conn, :for_worker, for_worker)
  end
end
