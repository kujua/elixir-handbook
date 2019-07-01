defmodule Ros.Lib.Enum.OrderSource do
  @moduledoc false

  @type t :: %__MODULE__{
               service:             Ros.Lib.Enum.Base.t,
               telephone:           Ros.Lib.Enum.Base.t,
               online_takeaway:     Ros.Lib.Enum.Base.t,
               telephone_takeaway:  Ros.Lib.Enum.Base.t
             }

  @derive Jason.Encoder
  defstruct service:            %Ros.Lib.Enum.Base{key: :service, value: "Service"},
            telephone:          %Ros.Lib.Enum.Base{key: :telephone, value: "Telephone"},
            online_takeaway:    %Ros.Lib.Enum.Base{key: :online_takeaway, value: "Online Takeaway"},
            telephone_takeaway: %Ros.Lib.Enum.Base{key: :telephone_takeaway, value: "Telephone Takeaway"}

end