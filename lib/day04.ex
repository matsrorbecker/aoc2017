defmodule Day04 do

  def solve_first do
    {:ok, content} = File.read "./input/day04/input.txt"
    parse_input(content)
    |> test_passphrases(0)
  end

  def solve_second do
    {:ok, content} = File.read "./input/day04/input.txt"
    parse_input(content)
    |> test_passphrases2(0)
  end

  defp parse_input(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(&(String.split(&1, ~r/\s/, trim: true)))
  end

  defp test_passphrases([], valid_passphrases), do: valid_passphrases
  defp test_passphrases([next|rest], valid_passphrases) do
    if is_valid next do
      test_passphrases rest, valid_passphrases + 1
    else
      test_passphrases rest, valid_passphrases
    end
  end

  defp is_valid(passphrase) do
    length(Enum.uniq passphrase) == length(passphrase)
  end

  defp test_passphrases2([], valid_passphrases), do: valid_passphrases
  defp test_passphrases2([next|rest], valid_passphrases) do
    if is_valid2 next do
      test_passphrases2 rest, valid_passphrases + 1
    else
      test_passphrases2 rest, valid_passphrases
    end
  end

  defp is_valid2(passphrase) do
    is_valid(passphrase) and !contains_anagrams(passphrase)
  end

  defp contains_anagrams(passphrase) do
    true in for i <- passphrase, j <- passphrase, do: are_anagrams i, j
  end

  defp are_anagrams(word1, word2) do
    w1 = String.to_charlist word1
    w2 = String.to_charlist word2
    w1 != w2 and Enum.sort(w1) == Enum.sort(w2)
  end

end
