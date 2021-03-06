defmodule Solar do

  # Use pattern matching to claculate flare-power based on conditions within
  #  each flare Map instance.
  # Below is a simple example of pattern matching against a flare Map:
  #
  # def power(%{classification: :C, scale: s}), do: s * 1
  # def power(%{classification: :M, scale: s}), do: s * 10
  # def power(%{classification: :X, scale: s}), do: s * 1000
  #
  # Another way of perfoming the above procedure, based on the conditions in
  #  each flare, is with the `cond` statement (like a *switch* or *case*
  #  statement in Elixir).
  # This is not a preferred pattern for Elixir, much like `if`, `unless`, or
  #  `case` statements (which are Macros, and not a language construct), its
  #  just another option. Pattern matching and guard clauses are the preferred
  #  idiom(s).
  def power_cond(flare) do
    factor = cond do
      flare.classification == :M -> 10
      flare.classification == :X -> 1000
      true -> 1 # This is the default or catch-all clause of `cond`.
    end
    factor * flare.scale
  end
  #
  # As requirements expand, the drawbacks to adding conditionals to meet said
  #  requirements becomes more apparent. If, as demonstrated below, the
  #  requirements also include a need to modify the power reading based on the
  #  number of stations that have recorded each flare, guard clauses serve to
  #  enhance the pattern matching idiom, rather than resort to polluting code
  #  with nested conditionals.
  def power(%{classification: :C, scale: s}), do: s
  def power(%{classification: :M, scale: s}), do: s * 10
  def power(%{classification: :X, scale: s, stations: c}) when c < 5,
    do: s * 1000 * 1.1
  def power(%{classification: :X, scale: s, stations: c}) when c >= 5,
    do: s * 1000

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

  # Yet another way to "reduce" the list of flare-power levels to a single
  #  value is a Comprehension (see end of ch 10, and middle of ch 11).
  def total_flare_power_comprehension(flares) do
    # Don't be tricked by the `for` keyword! A Comprehension is *not* a loop.
    # Wrap the Comprehension in paranthesis, to prevent the first evaluation
    #  of `power()` to be piped to `Enum.sum`.
    (for flare <- flares, do: power(flare)) |> Enum.sum
  end

  # Demonstrate data transformation by producing a keyword list of flare-power
  #  and a rating of how deadly each is.
  # One way of doing this is via a Comprehension with several generators to
  #  produce each value in the resulting List or Map:
  def flare_list(flares) do
    # Get `flare` from the first generator, and use it in the second. Get
    #  `power` from the second generator, and use it in the third. Then get
    #  `is_deadly` from the third generator. Then build a member of the
    #  enumerable from the results of the generators. Its not a loop, I swear!
    for flare <- flares,
      power <- [power(flare)],
      is_deadly <- [power > 1000],
      do: %{power: power, is_deadly: is_deadly}
  end
  # The above demonstrates the power of Elixir yet again, but for this simple
  #  purpose, it is not as clear or concise. The following uses `Enum.map` to
  #  produce the same enumerable of Map instances, with more clear or easy to
  #  comprehend code.
  def flare_list_enum(flares) do
    Enum.map flares, fn(flare) ->
      p = power(flare)
      %{power: p, is_deadly: p > 1000}
    end
  end

end
