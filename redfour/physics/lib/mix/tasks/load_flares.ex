# Another approach to adding data or schema changes is to create a custom
#  Mix Task.
# See Ch 15
defmodule Mix.Tasks.Physics.LoadFlares do

  use Mix.Task

  def run(args) do
    IO.inspect "HI!"
  end
end
