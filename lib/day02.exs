defmodule Day02 do
  
  def solve_first do
    {:ok, content} = File.read "./input/day02/input.txt"
    input = to_number_matrix content
    checksum input
  end

  def solve_second do
    {:ok, content} = File.read "./input/day02/input.txt"
    input = to_number_matrix content
    checksum2 input
  end

  defp to_number_matrix(string) do
    String.split(string, "\n", trim: true)
    |> Enum.map(&(String.split(&1, "\t", trim: true)))
    |> Enum.map(&(Enum.map(&1, fn(val) -> String.to_integer(val) end)))
  end

  defp checksum(matrix) do
    Enum.reduce(matrix, 0, fn(row, acc) -> calc_diff(row) + acc end)
  end

  defp calc_diff(row) do
    Enum.max(row) - Enum.min(row)
  end

  defp checksum2(matrix) do
    Enum.reduce(matrix, 0, fn(row, acc) -> calc_quotient(row) + acc end)
  end

  defp calc_quotient(row) do
    {first, second} = find_evenly_divisible(row)
    div(first, second)
  end

  defp find_evenly_divisible(row) do
    [{first, second}] = for i <- row, j <- row, i != j, rem(i, j) == 0, do: {i, j}
    {first, second}
  end

end