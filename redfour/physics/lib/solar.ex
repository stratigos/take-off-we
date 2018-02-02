defmodule Solar do

  def power(%{classification: :C, scale: s}), do: s * 1
  def power(%{classification: :M, scale: s}), do: s * 10
  def power(%{classification: :X, scale: s}), do: s * 1000

  # Long version for function definition:
  # def no_eva(flares) do
  #   Enum.filter flares, fn(flare) ->
  #     power(flare) > 1000
  #   end
  # end
  #
  # The following shorthand can be extrapolated to the above
  #  commented block:
  # Note:
  #  `&()` denotes an anonymous function
  #  `&1` denotes the first argument passed into current func scope
  def no_eva(flares), do: Enum.filter flares, &(power(&1) > 1000)

  def deadliest(flares) do
    Enum.map(flares, &(power(&1)))
      |> Enum.max
  end

  # Recursion in Elixir is performed via pattern matching and head|tail
  #  splitting between definition of a function's arity. This is, of course,
  #  how someone immersed in the OOP-paradigm would describe a functional
  #  language :). See the end of chapter 10 and beginning of chapter 11
  #  for detailed info.
  # Reduce a list of solar flare Maps to a single value, recursively, beginning
  #  with this function signature.
  def total_flare_power(list) do
    # Call self, passing the initial value of the accumulator, as would be done
    #  for a reduce method (in Ruby, JavaScript, etc).
    total_flare_power list, 0
  end
  # Define the final statement in the recursive pattern next, as this is the exit
  #  point of the function.
  def total_flare_power([], total), do: total
  # Next, define what happens when the List is non empty. Split the List into a
  # `head` and `tail`, add the `head` to the accumulated value, and perform the
  #  process again on the `tail`.
  #
  # def total_flare_power([head | tail], total) do
  #   new_total = power(head) + total
  #   total_flare_power(tail, new_total)
  # end
  #
  # More calculations / adjustments are necessary, based on the "type" of flare
  #  in the list. Instead of simply creating a `head`, pattern match against
  #  the list item itself(Map, in this case), and perform each individual
  #  adjustment.
  # Create a pattern matching signature for the `M` class flare.
  def total_flare_power([%{classification: :M, scale: s} | tail], total) do
    new_total = s * 10 * 0.92 + total
    total_flare_power(tail, new_total)
  end
  # ...repeat for `C` class flares...
  def total_flare_power([%{classification: :C, scale: s} | tail], total) do
    new_total = s * 0.78 + total
    total_flare_power(tail, new_total)
  end
  # ...and repeat once more for `X` class flares.
  def total_flare_power([%{classification: :X, scale: s} | tail], total) do
    new_total = s * 1000 * 0.68 + total
    total_flare_power(tail, new_total)
  end

  # The above methodology for `total_flare_power` is overkill for this simple
  #  sum, given the `Enum.reduce/3` function. While it serves as a demo of the
  #  power of pattern matching, its far too verbose for something accomplished
  #  by a core library (below).
  def total_flare_power_enum(flares) do
    Enum.reduce flares, 0, fn(flare, total) ->
      power(flare) + total
    end
  end

end
