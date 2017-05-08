defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "if hash_input/1 returns the same hash for the same input" do
    i = "foo"
    hash1 = Identicon.hash_input(i)
    hash2 = Identicon.hash_input(i)
    assert hash1 === hash2
  end
end
