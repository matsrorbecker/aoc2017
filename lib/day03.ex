defmodule Day03 do

  def solve_first do
    spiral = build_spiral(368078)
    {pos, _} = Enum.find spiral, fn {_, val} -> val == 368078 end
    manhattan_distance(pos, {0, 0})
  end

  defp build_spiral(positions) do
    # Initial values:
    current_pos = {1, 0}
    facing = :east
    spiral = %{{0, 0} => 1, {1, 0} => 2}
    count = 2
    # Here we go
    build_spiral(positions, current_pos, facing, spiral, count)
  end
  defp build_spiral(positions, _, _, spiral, count) when count == positions, do: spiral
  defp build_spiral(positions, current_pos, facing, spiral, count) do
    now_facing = get_direction facing, current_pos, spiral
    new_pos = get_pos now_facing, current_pos
    build_spiral positions, new_pos, now_facing, Map.put(spiral, new_pos, count + 1), count + 1
  end

  defp get_direction(facing, current_pos, spiral) do
    unless spiral[look_left(facing, current_pos)] do
      turn facing
    else
      facing
    end
  end

  defp look_left(facing, current_pos), do: get_pos turn(facing), current_pos

  defp turn(:east), do: :north
  defp turn(:north), do: :west
  defp turn(:west), do: :south
  defp turn(:south), do: :east

  defp get_pos(:east, {x, y}), do: {x + 1, y}
  defp get_pos(:north, {x, y}), do: {x, y + 1}
  defp get_pos(:west, {x, y}), do: {x - 1, y}
  defp get_pos(:south, {x, y}), do: {x, y - 1}

  defp manhattan_distance({x1, y1}, {x2, y2}), do: abs(x1 - x2) + abs(y1 - y2)

end