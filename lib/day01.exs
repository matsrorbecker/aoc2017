defmodule Day01 do

  def solve do
    {:ok, content} = File.read "./input/day01/input.txt"
    input = String.trim(content)
    |> String.split("", trim: true)
    |> Enum.map(&(String.to_integer(&1)))
    [first|_] = input
    first_answer = sum_matching input, 0, first
    indexed_input = Enum.with_index input
    second_answer = sum_matching2 indexed_input
    IO.puts first_answer
    IO.puts second_answer
  end

  defp sum_matching([last|[]], sum, first) when last == first, do: sum + last
  defp sum_matching([_|[]], sum, _), do: sum
  defp sum_matching([current|[next|rest]], sum, first) when current == next do
    new_sum = sum + current
    sum_matching [next|rest], new_sum, first
  end
  defp sum_matching([_|rest], sum, first), do: sum_matching rest, sum, first 

  defp sum_matching2(input) do
    length = Enum.count input
    half = div(length, 2)
    pairs = Enum.map(input, fn({val, i}) -> {val, get_other(Enum.at(input, rem(i + half, length)))} end)
    sum_matching2 pairs, 0
  end
  defp sum_matching2([], sum), do: sum
  defp sum_matching2([{first, second}|rest], sum) when first == second do
    new_sum = sum + first
    sum_matching2 rest, new_sum
  end
  defp sum_matching2([_|rest], sum), do: sum_matching2 rest, sum
  defp get_other({val, _}), do: val
end