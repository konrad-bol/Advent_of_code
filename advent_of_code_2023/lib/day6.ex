defmodule Day6 do
  def calc(input) do
    [time,distance]=input
    |> String.split(["Time:","Distance:"], trim: true)
    |> Stream.map(&String.trim(&1))
    |> Stream.map(&String.split(&1," ",trim: true))
    |> Enum.map(&Enum.map(&1,fn x -> String.to_integer(x) end))
    Enum.zip(time,distance)
    |>Enum.map(&gap(&1))
    |>Enum.product()
  end
  def gap({time,distance}) do
    sqer_delta=Integer.pow(time,2)-4.0*distance
    |>Float.pow(0.5)
    {time/2-sqer_delta/2,time/2+sqer_delta/2}
    |>natural_gap()
  end
  def natural_gap({left_zero,right_zero}) do
    ceil(left_zero)..floor(right_zero)
    |>Enum.to_list()
    |>length()
  end

  def calc_part2(input) do
    [time,distance]=input
    |> String.split(["Time:","Distance:"], trim: true)
    |> Enum.map(&String.trim(&1))
    |> Enum.map(&String.replace(&1," ",""))
    |> Enum.map(&String.to_integer&1)
    gap({time,distance})
  end
end
