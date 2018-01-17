# Do all of the things cohesive to the whooshing and screaching of rockets.
defmodule Physics.Rocketry do

  import Calcs
  import Converter
  import Physics.Laws
  import Planets

  def escape_velocity(:earth) do
    earth
      |> escape_velocity
  end

  def escape_velocity(:mars) do
    mars
      |> escape_velocity
  end

  def escape_velocity(:moon) do
    moon
      |> escape_velocity
  end
  def escape_velocity(planet) when is_map(planet) do
    planet
      |> calculate_escape
      |> to_km
      |> to_nearest_tenth
  end
end
