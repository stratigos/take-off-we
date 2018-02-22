# Another approach to adding data or schema changes is to create a custom
#  Mix Task.
# See Ch 15
defmodule Mix.Tasks.Physics.LoadFlares do

  use Mix.Task

  # Prefix `args` with an underscore to allow the Elixir compiler to recognize
  #  that we intend not to use it (and no need to emit a warning about an
  #  unused var).
  def run(_args) do
    IO.inspect "HI!"
  end
end
