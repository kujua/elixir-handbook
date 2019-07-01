defmodule Ros.RunnerWeb.Router do
  use Ros.RunnerWeb, :router

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

  scope "/", Ros.RunnerWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  defp put_for_worker(conn, _) do
    for_worker = "Runner:" <> Ros.RunnerWeb.Endpoint.config(:runner_number, "1")
    assign(conn, :for_worker, for_worker)
  end
end
