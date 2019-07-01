defmodule Ros.SupervisorWeb.Router do
  use Ros.SupervisorWeb, :router

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

  scope "/", Ros.SupervisorWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/testservice/hello", TestserviceController, :getservice
  end

  defp put_for_worker(conn, _) do
    for_worker = "Supervisor:" <> Ros.SupervisorWeb.Endpoint.config(:supervisor_number, "0")
    assign(conn, :for_worker, for_worker)
  end
end
