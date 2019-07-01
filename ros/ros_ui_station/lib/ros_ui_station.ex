defmodule Ros.Station do
  @moduledoc false

  def get_station_title do
     stationnumber = Ros.StationWeb.Endpoint.config(:station_number, "1")
     "Station " <> stationnumber
  end
end
