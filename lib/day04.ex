defmodule Day04 do

  def solve_first do
    {:ok, content} = File.read "./input/day04/input.txt"
    String.split(content, "\n", trim: true)
    |> Enum.map(&(String.split(&1, ~r/\s/, trim: true)))
    |> test_passphrases(0)
  end

  defp test_passphrases([], valid_passphrases), do: valid_passphrases
  defp test_passphrases([next|rest], valid_passphrases) do
    if is_valid next do
      test_passphrases rest, valid_passphrases + 1
    else
      test_passphrases rest, valid_passphrases
    end
  end

  def is_valid(passphrase) do
    length(Enum.uniq passphrase) == length(passphrase)
  end

end
