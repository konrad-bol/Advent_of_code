defmodule Cube do
 alias Cube.DataSort

  def sum_of_valid_game() do
    DataSort.divider()
    |>Enum.reduce(0,fn {id,game},acc ->
      if valid_game?(game) do
        acc+id
      else
      acc
      end
    end)
  end
  def valid_game?(game) do
    game
    |> Enum.all?(&(valid_state?(&1)))
  end

  def valid_state?({color,amount}) do
      case {color,amount} do
        {:red, q} when q >12 -> false
        {:green, q} when q >13 -> false
        {:blue, q} when q >14 -> false
        _ -> true
      end
  end
  #part 2

  def sum_of_power_set() do
    DataSort.divider()
    |> Enum.map(fn {_id,game} ->
      find_min_set_power(game)
    end)
    |> Enum.sum()

  end

  def find_min_set_power(game) do
    game
    |> Enum.group_by(fn {color,_number}-> color end, fn {_color,number} -> number end)
    |> Enum.map(fn {_color,list} -> Enum.max(list) end)
    |> Enum.product()
  end
end
