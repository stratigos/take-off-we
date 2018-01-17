# Do all of the things cohesive to the whooshing and screaching of rockets.
defmodule Physics.Rocketry do

  #################################################################
  # Chapter 7 notes:
  # - The mass of Mars is 6.39e23kg and its radius is 3.4e6m.
  # - The mass of the Moon is 7.35e22kg and its radius is 1.73e6m.
  #################################################################

  import Calcs
  import Converter

  # Use Module attributes to remove data from function signatures
  @moon  %{ mass: 7.35e22, radius: 1.738e6 }
  @mars  %{ mass: 6.39e23, radius: 3.4e6 }
  @earth %{ mass: 5.972e24, radius: 6.372e6 }

  def escape_velocity(:earth) do
    %{ mass: 5.972e24, radius: 6.371e6 }
     |> escape_velocity
  end

  # Calculate the necessary escape velocity for planetary gravity.
  def escape_velocity(planet) when is_map(planet) do
    planet
      |> calculate_escape
      |> Converter.to_km
      |> Converter.to_nearest_tenth
  end

  defp calculate_escape(%{ mass: mass, radius: radius }) do
    newtons_constant = 6.67e-11

    2 * newtons_constant * mass / radius
     |> :math.sqrt
  end

end
