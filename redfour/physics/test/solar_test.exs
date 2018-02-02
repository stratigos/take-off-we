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
      %{classification: :X, stations: 10, scale: 99, date: Date.from({1859, 8, 29})},
      %{classification: :M, stations: 10, scale: 5.8, date: Date.from({2015, 1, 12})},
      %{classification: :M, stations: 6, scale: 1.2, date: Date.from({2015, 2, 9})},
      %{classification: :C, stations: 6, scale: 3.2, date: Date.from({2015, 4, 18})},
      %{classification: :M, stations: 7, scale: 83.6, date: Date.from({2015, 6, 23})},
      %{classification: :C, stations: 10, scale: 2.5, date: Date.from({2015, 7, 4})},
      %{classification: :X, stations: 2, scale: 72, date: Date.from({2012, 7, 23})},
      %{classification: :X, stations: 4, scale: 45, date: Date.from({2003, 11, 4})},
    ]
    {:ok, data: flares}
  end

  test "We have 8 solar flares", %{data: flares} do
    assert length(flares) == 8
  end

  test "We can detect dangerous solar flares",  %{data: flares} do
    dangerous = Solar.no_eva(flares)
    assert length(dangerous) == 3
  end

  test "We can get the deadliest Solar flare", %{data: flares} do
    deadliest = Solar.deadliest(flares)
    assert deadliest == 99000
  end

  # test "total flare power using recursion", %{data: flares} do
  #   Solar.total_flare_power(flares) |> IO.inspect
  # end
  #
  # test "total flare power using enums", %{data: flares} do
  #   Solar.total_flare_power_enum(flares) |> IO.inspect
  # end
  #
  # test "a flare list with comprehensions", %{data: flares} do
  #   Solar.flare_list(flares) |> IO.inspect
  # end
  #
  # test "a flare list with enums", %{data: flares} do
  #   Solar.flare_list_enum(flares) |> IO.inspect
  # end

end
