defmodule CardsTest do
  use ExUnit.Case
  doctest Cards, except: [:cards, deal: 2]

  test "the truth" do
    assert 1 + 1 == 2
  end
end
