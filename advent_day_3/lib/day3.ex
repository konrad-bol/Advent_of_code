defmodule Day3 do
  def calc(input) do
    input = input |> String.split("\n", trim: true) |> Enum.with_index()

    symbols =
      Enum.reduce(input, %{}, fn {line, index}, acc ->
        value =
          line
          |> String.graphemes()
          |> Enum.with_index()
          |> Enum.reject(fn {char, _i} ->
            String.contains?(char, ".") or Regex.match?(~r/[0-9]/, char)
          end)
          |> Enum.map(fn {_, i} -> i end)

        Map.put(acc, index, value)
      end)

    input
    |> Enum.reduce(0, fn {line, index}, acc ->
      up = symbols[index - 1] || []
      down = symbols[index + 1] || []
      current = symbols[index] || []
      symbols = Enum.uniq(up ++ down ++ current)
      numbers = Regex.scan(~r/[0-9]+/, line, return: :index, capture: :first) |> List.flatten()

      s =
        numbers
        |> Enum.filter(fn {x, y} ->
          y = y + x
          range = x..y
          Enum.any?(symbols, fn s -> s in range || (s - 1) in range || (s + 1) in range end)
        end)
        |> Enum.map(fn {x, y} ->
          String.slice(line, x, y)
        end)
        |> Enum.map(&String.to_integer/1)
        |> Enum.sum()

      s + acc
    end)
  end
end
