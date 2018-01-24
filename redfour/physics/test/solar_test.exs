defmodule SolarTest do
  # The `use` macro requires a module and sends a `__using__` method to it.
  #  This allows for passing an optional setting, usually in the form of a
  #  keyword list.
  # E.g., `use ExUnit.Case, async: true` (which will execute everything in
  #  parallel, which will most likely speed up test suite runtime).
  use ExUnit.Case
  use Timex

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

  # `setup` is the test setup for this module. Use `setup_all` for a
  #  before-suite callback.
  setup do
    flares = [
      %{classification: :X, scale: 99, date: Date.from({1859, 8, 29})},
      %{classification: :M, scale: 5.8, date: Date.from({2015, 1, 12})},
      %{classification: :M, scale: 1.2, date: Date.from({2015, 2, 9})},
      %{classification: :C, scale: 3.2, date: Date.from({2015, 4, 18})},
      %{classification: :M, scale: 83.6, date: Date.from({2015, 6, 23})},
      %{classification: :C, scale: 2.5, date: Date.from({2015, 7, 4})},
      %{classification: :X, scale: 72, date: Date.from({2012, 7, 23})},
      %{classification: :X, scale: 45, date: Date.from({2003, 11, 4})},
    ]
    {:ok, data: flares}
  end

  test "We have 8 solar flares", %{data: flares} do
    assert length(flares) == 8
  end
end
