# This `.exs` file is an Elixir Script, which is compiled at runtime.
# Mix is the following:
#  - a compiler
#  - a test runner
#  - a task runner
#  - a generator
# To contrast with IEX :
#  - REPL
#  - runs tasks interactively
# This Mix file could be run by IEX as:
#  - `iex -S mix`
#  Then, when IEX is loaded, type:
#  - `:observer.start`
#  ... and behold the Erlang process tree and all kinds of useful, visualized
#  info about the application's runtime. All info is on the running processes
#  running on the current Erland VM.
defmodule Physics.Mixfile do
  use Mix.Project

  def project do
    [
      app: :physics,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :timex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:timex, "~> 2.1.4"}, # This learning video was created ca. Elixir 1.2 (before time datatypes)
      {:ecto, "~> 2.2"},
      {:postgrex, "~> 0.13.5"},
      # {:amnesia, "~> 0.2.7"}, # Note that using the github repo (as in ch 13) is broken. DL from Hex.
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
