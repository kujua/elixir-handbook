defmodule Ros.StationWeb.PageController do
  use Ros.StationWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
