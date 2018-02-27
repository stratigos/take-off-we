# Demonstrate Elixir's capabilities with concurrency by "blowing up" the PSQL
#  DB with concurrent requests. See ch 17.
defmodule SolarFlareRecorderDBStress do
  use GenServer

  # Default implementation of `#init()`, to remove warning.
  def init(args) do
    {:ok, args}
  end

  # Create a process.
  def start_link do
    Agent.start_link fn -> [] end
  end

  # Do some stuff with the process - namely add a `flare` to the state.
  def record_flare(pid, flare) do
    Agent.get_and_update pid, fn(flares) ->
      new_flares = List.insert_at(flares, -1, flare)
      add_flare(flare)
      {new_flares,new_flares}
    end
  end

  defp add_flare(flare) do
    """
    insert into solar_flares(classification, scale, stations, inserted_at, updated_at)
    values($1, $2, 100, now(), now()) RETURNING *;
    """
    |> execute([flare.classification, flare.scale])
  end


  defp execute(sql,params) do
    {:ok, pid} = connect()

    Postgrex.query!(pid, sql, params)
  end

  # Since Ecto is *"pretty good at preventing developers from shooing themselves
  #  in the foot with the power of OTP"*, that layer of our app needs to be
  #  bypassed, and PostgreSQL accessed directly.
  defp connect do
    Postgrex.start_link(
      hostname: "localhost",
      database: "taking_off_with_elixir",
      username: "postgres",
      password: "postgres"
    )
  end

end

# Execute with `mix run bomb.exs`
#  Start with 20 and watch it work
#  Then go to 100
#  Then to 1000...

# My laptop chokes around the 91st process run :). The following `Enum.map()`
#  call will create N-many processes and run them concurrently. If this is
#  actually concurrent, and not asynchronous, then PostgreSQL connection pool
#  should easily get maxed out and crash. If these processes were run async,
#  then its unlikely the connection pool would ever reach its maximum.
Enum.map 1..100, fn(_n) ->
  # Create an Agent - each a single process in memory.
  {:ok, pid} = SolarFlareRecorderDBStress.start_link

  # Execute a command for the process `pid`.
  SolarFlareRecorderDBStress.record_flare(pid, %{classification: "X", scale: 33, stations: 10})
end


IO.inspect "DONE"
