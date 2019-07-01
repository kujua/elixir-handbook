defmodule Ros.Lib.Enum.Base do
  @moduledoc false

  @type t :: %__MODULE__{
               key:    atom,
               value:  String.t
             }

  @derive Jason.Encoder
  defstruct key: nil,
            value: nil
end