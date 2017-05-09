defmodule Identicon do
  @moduledoc """
  Generates a random image for a String.
  """

  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
  end
  
  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end

  # def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
  def pick_color(image) do
    # %Identicon.Image{hex: [r, g, b | _tail]} = image
    [r, g, b | _tail] = image.hex
    
    %Identicon.Image{image | color: {r, g, b}}
  end

  def build_grid(%Identicon.Image{hex: hex}) do
    hex
    |> Enum.chunk(3)
    |> Enum.map(&mirror_row/1)
  end

  @doc """
    Mirrors a list of 3 elements

  # Examples

      iex> Identicon.mirror_row [1, 2, 3]
      [1, 2, 3, 2, 1]
  """
  def mirror_row([x, y, z]) do
    [x, y, z, y, x]
  end
  
  # Version from the course:
  #
  # def mirror_row(row) do
  #   [first, second | _tail] = row
  #   row ++ [second, first]
  # end
  
end
