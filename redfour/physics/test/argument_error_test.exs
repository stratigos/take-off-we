defmodule ArgumentErrorTest do
  use ExUnit.Case

  def say_hello(name, opts) do
    "Hello #{name}, I see that you're #{opts[:age]} years old"
  end

  # Previously this was broken by not referencing the String module.
  test "a noncompiling Erlang error" do
    val = say_hello("Steve", age: 12)
      |> IO.inspect # "Knuckle-Drag Debugging" eh? Nothing wrong with tried and true classics ;-)

    assert String.length(val) > 10
  end
end
