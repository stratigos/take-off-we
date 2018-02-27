# Run a bunch of processes concurrently - the `say` command will simulate
#  singing some text through multiple concurrent "singers", which will sound
#  like a choir.
defmodule Choir do

  # Store the types of sounds for the `say` command in a module attr.
  # @see [module attributes](https://elixir-lang.org/getting-started/module-attributes.html)
  @voices ["Bells", "Good News", "Pipe Organ", "Cellos", "Bad News"]

  def sing do
    # Uncomment the following line for a single process example:
    # {:ok, pid} = Singer.start_link

    # The following will "sing" the phrase N many times. 20 is a good choice,
    #  as higher numbers of processes can overload a sound driver and crash
    #  your localdev ;-).
    Enum.map 1..20, fn(n) ->
      # These will each run at the same time.
      {:ok, pid} = Singer.start_link

      # Choose a random sound / voice style.
      voice = Enum.random(@voices)

      Singer.sing_it pid, voice
    end
  end

  # Choir.groups - create a "conductor" process that runs groups of
  #  "singing" processes.
  def groups do
    Enum.map 1..3, fn(n) ->
      voice = case n do
        1 -> "Cellos"
        2 -> "Good News"
        3 -> "Pipe Organ"
      end

      # `spawn` is the basic mechanism for starting a process
      # @see [spawn](https://elixir-lang.org/getting-started/processes.html#spawn)
      spawn Choir, :conductor, [voice]
    end
  end

  def conductor(voice) do
    Enum.map 1..5, fn(_n) ->
      {:ok, pid} = Singer.start_link
      Singer.sing_it(pid, voice)
    end
  end

  # Choir.staggered - uses recursion and a timer to stagger the voices.
  def staggered do
    Enum.to_list(1..20) |> staggered
  end
  def staggered([head | tail]) do
    {:ok, pid} = Singer.start_link

    Singer.sing_it pid, "Cello"

    # Stagger by 200ms.
    # `:timer` is an Atom as it is part of the Erlang library.
    :timer.sleep 200

    staggered tail
  end
  def staggered([]) do
    IO.puts "All Done"
  end

end

# Define a process to run within the current process (i.e., IEx).
# Note that the `say` command is required for the current system.
defmodule Singer do
  use GenServer

  # Default implementation of `init()` to avoid warning.
  def init(args) do
    {:ok, args}
  end

  def start_link do
    GenServer.start_link(__MODULE__,[])
  end

  def sing_it(pid, data) do
   GenServer.cast(pid, {:sing, data})
  end

  def handle_cast({:sing, voice}, _state) do
    IO.puts "Singing with #{voice}"

    System.cmd "say", ["-v", voice, "Elixir Is AWESOME"]

    {:noreply, []}
  end
end
