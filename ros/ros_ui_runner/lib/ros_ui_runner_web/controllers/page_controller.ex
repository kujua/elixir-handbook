defmodule Ros.RunnerWeb.PageController do
  use Ros.RunnerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
