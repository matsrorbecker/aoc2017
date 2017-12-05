defmodule Day05 do

  def solve_first do
    {:ok, content} = File.read "./input/day05/input.txt"
    parse_instructions(content)
    |> jump(0, 0)
  end

  def solve_second do
    {:ok, content} = File.read "./input/day05/input.txt"
    parse_instructions(content)
    |> jump2(0, 0)
  end

  defp parse_instructions(input) do
    instruction_list = String.split(input, "\n", trim: true)
    |> Enum.map(&(String.to_integer/1))
    0..length(instruction_list)
    |> Stream.zip(instruction_list)
    |> Enum.into(%{})
  end

  defp jump(instructions, pos, steps) do
    if instructions[pos] == nil do
      steps
    else
      offset = instructions[pos]
      new_pos = pos + offset
      updated_instructions = Map.put instructions, pos, offset + 1
      jump updated_instructions, new_pos, steps + 1
    end
  end

  defp jump2(instructions, pos, steps) do
    if instructions[pos] == nil do
      steps
    else
      offset = instructions[pos]
      new_pos = pos + offset
      new_offset = if offset >= 3 do
        offset - 1
      else
        offset + 1
      end
      updated_instructions = Map.put instructions, pos, new_offset
      jump2 updated_instructions, new_pos, steps + 1
    end
  end

end