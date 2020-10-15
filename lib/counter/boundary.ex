defmodule Counter.Boundary do
  use GenServer
  alias Counter.Core

  def inc(counter) do
    GenServer.cast(counter, :inc)
  end

  def state(counter) do
    GenServer.call(counter, :state)
  end

  def start_link(value) do
    GenServer.start_link(__MODULE__, Core.clear(value))
  end

  def init(value) when is_binary(value) do
    {:ok, String.to_integer(value)}
  rescue
    _ -> {:error, "Specificy an integer or string that converts to an integer"}
  end

  def init(value) when is_integer(value) do
    {:ok, value}
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  def handle_cast(:inc, value) do
    {:noreply, Core.inc(value)}
  end
end
