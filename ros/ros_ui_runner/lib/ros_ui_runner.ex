defmodule Ros.Runner do
  @moduledoc false

  def get_runner_title do
     runnernumber = Ros.RunnerWeb.Endpoint.config(:runner_number, "1")
     "Runner " <> runnernumber
  end
end
