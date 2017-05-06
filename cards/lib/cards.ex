defmodule Cards do
  @moduledoc """
    Provides functions for creating and handling a deck of cards.
  """

  @doc """
    Creates a list of strings representing a deck of playing cards.
  """
  def create_deck do
    values = [
      "Ace", "Two", "Three",
      "Four", "Five", "Six",
      "Seven", "Eight", "Nine",
      "Ten", "Jack", "Queen",
      "King"
    ]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle deck
  end
  
  @doc """
    Determines whether a deck contains a given `card`

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck, card) do
    Enum.member? deck, card
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should
    be in the hand.

  ## Examples

      iex> shuffled_deck = Cards.create_deck |> Cards.shuffle
      iex> {hand, remaining_deck} = Cards.deal(shuffled_deck, 2)
      iex> hand
      ["Three of Spades", "Four of Diamonds"]
  """
  def deal(deck, hand_size) do
    Enum.split deck, hand_size
  end
  
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "Something went wrong."
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
  
end
