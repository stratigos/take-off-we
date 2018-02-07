# I labeled this "DatabaseTest" as "AmnesiaTest" sounds misleading to me.
#  See chapter 13.
defmodule DatabaseTest do
  use ExUnit.Case
  use Amnesia
  use Physics.Database

  setup_all do

    Amnesia.Schema.create
    Amnesia.start
    Physics.Database.create!

    res = Amnesia.transaction! do
      planets = [
        %Planet{name: "Mercury", type: :rocky, mass: 3.3e23, radius: 2.439e6},
        %Planet{name: "Venus", type: :rocky, mass: 4.86e24, radius: 6.05e6},
        %Planet{name: "Earth", type: :rocky, mass: 5.972e24, radius: 6.37e6},
        %Planet{name: "Mars", type: :rocky, mass: 6.41e23, radius: 3.37e6},
        %Planet{name: "Jupiter", type: :gaseous, mass: 1.89e27, radius: 7.14e7},
        %Planet{name: "Saturn", type: :gaseous, mass: 5.68e26, radius: 6.02e7},
        %Planet{name: "Uranus", type: :gaseous, mass: 8.68e25, radius: 2.55e7},
        %Planet{name: "Neptune", type: :gaseous, mass: 1.02e26, radius: 2.47e7}
      ]
      for planet <- planets, do: planet |> Planet.write!
    end

    on_exit fn ->
      Physics.Database.destroy
      Amnesia.stop
      Amnesia.Schema.destroy
    end

    :ok
  end

  test "It can read the planet using id 1" do
    p = Amnesia.transaction! do
      Planet.read(1)
    end

    assert p.id == 1
  end

  test "It reads rocky planets using match" do
    planets = Amnesia.transaction! do
      [type: :rocky] |> Planet.match
    end

    assert length(planets.values) == 4
  end

  test "using where" do
    planets = Amnesia.transaction! do
      # No need for Type safety - the Database Types are converted to Elixir
      #  Types (in this case, a symbol, I mean, uhm, an atom!) by Amnesia.
      #  This is true in reverse; Erlang and Elixir Types are converted into
      #  whatever the Database (column) Type is. This is, of course, not
      #  related to the fact that the below example uses a field that just
      #  happens to be named `type` ;-). 
      Planet.where(type == :gaseous)
    end

    assert length(planets.values) == 4
  end

  test "first and next" do
    p = Amnesia.transaction! do
      Planet.first |> Planet.next
    end

    assert p.id == 2
  end

end
