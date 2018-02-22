# With chapter 14, the OTP platform was introduced by means of GenServer,
#  Agent, and Task. An Agent is a process that wraps the application state.
#  A Task is like a one-off process that returns a result, usually asynch.
#  GenServer is short for "Generic Server". These processes are usually
#  controlled by Supervisors, which can manage, restart, kill, etc the
#  various processes within the Erlang VM.
defmodule SolarFlareRecorder do
  # GenServer is a behavior module for the serverside of a client-server
  #  relationship. Its like the accumulator portion of a reducer, but
  #  for application state (see chapter 14, intro to chapter 15).
  use GenServer

  def init(args) do
    {:ok, args}
  end

  # example public API #1
  def start_link do
    Agent.start_link fn -> [] end
  end

  # example public API #2
  # def record_flare(pid, {:flare, classification: c, scale: s} = flare) do
  #   # This agent acts like the "accumulator" for application state, in this
  #   #  case, updating solar flare data.
  #   Agent.get_and_update pid, fn ->
  #     new_state = List.insert_at flares, -1, flare
  #       {:ok, new_state}
  #   end
  #
  # end

  # example public API #3
  # def get_flares do
  #   Agent.get pid, fn(flares) ->
  #     flares
  #   end
  # end

end
