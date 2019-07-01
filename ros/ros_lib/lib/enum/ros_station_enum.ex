defmodule Ros.Lib.Enum.Station do
  @moduledoc false

  @type t :: %__MODULE__{
               station:    Ros.Lib.Enum.Base.t,
               supervisor:  Ros.Lib.Enum.Base.t,
               runner:     Ros.Lib.Enum.Base.t,
             }

  @derive Jason.Encoder
  defstruct station: %Ros.Lib.Enum.Base{key: :station1, value: "Station:1"},
            supervisor: %Ros.Lib.Enum.Base{key: :supervisore, value: "Supervisor:0"},
            runner: %Ros.Lib.Enum.Base{key: :runner1, value: "Runner:1"}

end