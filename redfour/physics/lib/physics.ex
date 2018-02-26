defmodule Physics do
  use Application

  # The boilerplate supervised process code below can be generated via:
  #  `mix new physics - -sup` |
  # This creates a new supervision tree.
  # Start the application, and supervise its process.
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Note: the `#start_link` for this `Physics.Repo` process is defined in
      #  the macros of `Ecto.Repo`. These macros are an essential example of
      #  metaprogramming with compilation (a great Elixir feature).
      worker(Physics.Repo, []) # example 1
    ]

    # Supervision strategy options:
    # `one_for_one`        - restart any child process on termination.
    # `one_for_all`        - restart all child process if any terminates.
    # `rest_for_one`       - if a child process dies, then all children created
    #                        after it are terminated and restarted.
    # `simple_one_for_one` - just like `one_for_one` but allows for dynamic
    #                        addition and removal.
    opts = [strategy: :one_for_one, name: Physics.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
