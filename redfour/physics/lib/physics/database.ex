# Simple database using the Mnesia system.
defmodule Physics.Database do

  :mnesia.create_table(:user, [
    {:ram_copies, [node()]},
    {:attributes, [:name, :email, :first, :last]}
  ])

end
