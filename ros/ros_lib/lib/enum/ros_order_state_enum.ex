defmodule Ros.Lib.Enum.OrderState do
  @moduledoc false

  @type t :: %__MODULE__{
    ordered:  Ros.Lib.Enum.Base.t,
    prepare:  Ros.Lib.Enum.Base.t,
    serve:    Ros.Lib.Enum.Base.t,
    error:    Ros.Lib.Enum.Base.t,
    rejected: Ros.Lib.Enum.Base.t
  }

  @derive Jason.Encoder
  defstruct ordered: %Ros.Lib.Enum.Base{key: :ordered, value: "Ordered"},
            prepare: %Ros.Lib.Enum.Base{key: :prepare, value: "Prepared"},
            serve: %Ros.Lib.Enum.Base{key: :serve, value: "Serve"},
            error: %Ros.Lib.Enum.Base{key: :error, value: "An error occured"},
            rejected: %Ros.Lib.Enum.Base{key: :message_error, value: "A message error occured"}

end