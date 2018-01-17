defmodule CompilerProblemTest do
  use ExUnit.Case
  import Converter

  test "rounding an integer" do
    val = 19 |> round_to(0)
    assert val == 19.0
  end

  test "rounding a float" do
    val = 1.89 |> round_to(1)
    assert val == 1.9
  end

  test "converting m to km" do
    val = 120.5 |> to_km
    assert val == 193.121
  end
end
