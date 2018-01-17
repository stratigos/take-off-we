defmodule ArgumentErrorTest do
  use ExUnit.Case
  # require IEx # IEx "pry" debugger feature

  def say_hello(name, opts) do
    "Hello #{name}, I see that you're #{opts[:age]} years old"
  end

  # Previously this was broken by not referencing the String module.
  test "a noncompiling Erlang error" do
    # val = say_hello("Steve", age: 12)
    #   |> IO.inspect # "Knuckle-Drag Debugging" eh? Nothing wrong with tried and true classics ;-)
    val = say_hello "Steve", age: 12

    # IEx.pry # Open debug console here, when called inside IEx

    assert String.length(val) > 10
  end
end
