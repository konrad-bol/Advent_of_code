defmodule Data.DataList do

  def get_data_1() do
    "/Users/kodi/Desktop/advent_of_code/data_advent_of_code/assets/data_1.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end
  def get_data_2() do
    "../../../data_advent_of_code/assets/data_2.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end
end
