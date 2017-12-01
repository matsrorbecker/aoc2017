defmodule Day01 do

  def solve_first do
    {:ok, content} = File.read "./input/day01/input.txt"
    input = to_number_list content
    [first|_] = input
    sum_matching input, 0, first
  end

  def solve_second do
    {:ok, content} = File.read "./input/day01/input.txt"
    number_list = to_number_list(content)
    |> Enum.with_index
    length = Enum.count number_list
    half = div(length, 2)
    input = Enum.map(number_list, fn({val, i}) -> {val, get_val(Enum.at(number_list, rem(i + half, length)))} end)
    sum_matching2 input, 0
  end

  defp to_number_list(string) do
    String.trim(string)
    |> String.split("", trim: true)
    |> Enum.map(&(String.to_integer(&1)))
  end

  defp get_val({val, _}), do: val

  defp sum_matching([last|[]], sum, first) when last == first, do: sum + last
  defp sum_matching([_|[]], sum, _), do: sum
  defp sum_matching([current|[next|rest]], sum, first) when current == next do
    new_sum = sum + current
    sum_matching [next|rest], new_sum, first
  end
  defp sum_matching([_|rest], sum, first), do: sum_matching rest, sum, first 

  defp sum_matching2([], sum), do: sum
  defp sum_matching2([{first, second}|rest], sum) when first == second do
    new_sum = sum + first
    sum_matching2 rest, new_sum
  end
  defp sum_matching2([_|rest], sum), do: sum_matching2 rest, sum

end
