###############################################################################
# Modules for demonstrating idioms, and converting things to light speed!
# - Examples in Pattern Matching (ch 6)
# - Things and stuff (ch 7)
###############################################################################

defmodule ConverterTwo do

  def to_nearest_tenth(val) do
    round_to(val, 1)
  end

  def to_km(val) do
    val / 1000
  end

  def to_meters(val) do
    val * 1000
  end

  def to_light_seconds(arg), do: to_light_seconds(arg, precision: 5)
  def to_light_seconds({unit, val}, precision: precision) do
    light_seconds = case unit do
      :miles -> from_miles(val)
      :meters -> from_meters(val)
      :feet -> from_feet(val)
      :inches -> from_inches(val)
    end
    light_seconds |> round_to(precision) # example 2
  end

  defp from_miles(val), do: val * 5.36819e-6
  defp from_meters(val), do: val * 3.335638620368e-9
  defp from_feet(val), do: val * 1.016702651488166404e-9
  defp from_inches(val), do: val * 8.472522095734715723e-11
  defp round_to(val, precision), do: Float.round(val, precision)

end

defmodule Converter do
  def to_nearest_tenth(val) do
    round_to(val, 1)
  end

  def to_km(val) do
    val / 1000
  end

  def to_meters(val) do
    val * 1000
  end

  def to_light_seconds({:miles, miles} = val, precision: precision) do
    (miles * 5.36819e-6) |> round_to(precision)
  end

  def to_light_seconds({:meters, meters} = val, precision: precision)  do
    (meters * 3.335638620368e-9) |> round_to(precision)
  end

  def to_light_seconds({:feet, feet} = val, precision: precision)  do
    (feet * 1.016702651488166404e-9) |> round_to(precision)
  end

  def to_light_seconds({:inches, inches} = val, precision: precision)  do
    (inches * 8.472522095734715723e-11) |> round_to(precision)
  end

  def round_to(val, precision) when is_float(val) do
    Float.round(val, precision)
  end
  def round_to(val, precision) when is_integer(val) do
    round(val)/1
  end

  def seconds_to_hours(val)  when is_integer(val) or is_float(val) do
    val / 3600 |> to_nearest_tenth
  end

end
