defmodule Ros.SupervisorWeb.PageController do
  use Ros.SupervisorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
