defmodule Day03 do

  def solve_first do
    build_spiral(368078)
    |> Enum.at(-1)
    |> manhattan_distance({0, 0})
  end

  defp build_spiral(positions) do
    # Initial values:
    facing = :east
    spiral = [{1, 0}, {0, 0}]
    count = 2
    occupied = %{{1, 0} => true, {0, 0} => true}
    # Here we go
    build_spiral(positions, facing, spiral, count, occupied)
    |> Enum.reverse
  end
  defp build_spiral(positions, _, spiral, count, _) when count == positions, do: spiral
  defp build_spiral(positions, facing, spiral, count, occupied) do
    [current_pos|_] = spiral
    now_facing = get_direction facing, current_pos, occupied
    new_pos = get_pos now_facing, current_pos
    now_occupied = Map.put occupied, new_pos, true
    build_spiral positions, now_facing, [new_pos|spiral], count + 1, now_occupied
  end
  
  defp get_direction(facing, current_pos, occupied) do
    unless occupied[look_left(facing, current_pos)] do
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