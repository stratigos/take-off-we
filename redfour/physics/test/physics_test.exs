defmodule PhysicsTest do
  use ExUnit.Case
  doctest Physics

  test "Converting to to_light_seconds" do
    ls = Converter.to_light_seconds({:miles, 1000}, precision: 5)
    assert ls == 0.00537
  end

  test "Converter one works" do
    ls = Converter.to_light_seconds({:miles, 1000}, precision: 5)
    assert ls == 0.00537
  end

  test "ConverterTwo works" do
    ev = ConverterTwo.to_light_seconds({:miles, 1000}, precision: 5)
    assert ev == 0.00537
  end

  test "ConverterTwo works with default values" do
    ev = ConverterTwo.to_light_seconds({:miles, 1000})
    assert ev == 0.00537
  end

end
