defmodule IgnoredSpec do
  use ExUnit.Case

  test "This wont get called since the filename is not *_test.exs" do
    flunk "Oh noes!"
  end

end
