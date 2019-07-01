defmodule Ros.AdminWeb.PageController do
  use Ros.AdminWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
