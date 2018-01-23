defmodule SolarTest do
  # The `use` macro requires a module and sends a `__using__` method to it.
  #  This allows for passing an optional setting, usually in the form of a
  #  keyword list.
  # E.g., `use ExUnit.Case, async: true` (which will execute everything in
  #  parallel, which will most likely speed up test suite runtime).
  use ExUnit.Case

  # Use the `require` directive to load modules with macros to be injected at
  #  compile time (like `.pry`). Allows for metaprogramming.
  # require IEx

  # Use the `only` keyword when importing modules to select specific functions,
  #  instead of importing all of the things. The `except` keyword is the
  #  inverse of `only`.
  # import Physics.Laws, only: [newtons_gravitational_constant: 0] # List function arity.

  # Use the `alias` macro to make code more terse or legible (by way of
  #  reducing accessors to deeper parts of a module, as shown below).
  # alias Physics.Rocketry, as: Astrophysics
end
