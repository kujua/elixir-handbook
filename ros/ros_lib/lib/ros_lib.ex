defmodule Ros.Lib do
  @moduledoc false

  @spec set_status(struct, atom) :: struct
  def set_status(model, status) do
    %{model | status: status}
  end
end
