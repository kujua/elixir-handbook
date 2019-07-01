defmodule Ros.Service.Api.Supervisor do
  @moduledoc false

  use DynamicSupervisor

  def start_link(arg) do
    DynamicSupervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_child(_, _) do
    DynamicSupervisor.start_child(
      __MODULE__,
      {Ros.Service.Api.Worker, []}
    )
  end

end
