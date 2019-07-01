defmodule Ros.Lib.Enum.DishGroup do
  @moduledoc false

  @type t :: %__MODULE__{
               starter: Ros.Lib.Enum.Base.t,
               soup:    Ros.Lib.Enum.Base.t,
               main:    Ros.Lib.Enum.Base.t,
               dessert: Ros.Lib.Enum.Base.t
             }

  @derive Jason.Encoder
  defstruct starter:  %Ros.Lib.Enum.Base{key: :starter, value: "Starter"},
            soup:     %Ros.Lib.Enum.Base{key: :soup, value: "Soup"},
            main:     %Ros.Lib.Enum.Base{key: :main, value: "Main"},
            dessert:  %Ros.Lib.Enum.Base{key: :dessert, value: "Dessert"}

end

 