defmodule Day9 do

  def calc(input) do
    list=input
    |> String.split("\n",trim: true)
    |> Enum.map(&String.split(&1," ",trim: true))
    |> Enum.map(&Enum.map(&1,fn x -> String.to_integer(x) end))
    |> Stream.flat_map(fn list ->
    Stream.transform(list,
    fn -> list end,

    fn _element, line ->
      if( Stream.drop(line,1)|>Enum.empty?() ||line |>Enum.all?(&(&1==0)) ) do
        {:halt,0}
      else
        new_line = Stream.zip_with(Stream.drop(line,1),line, fn x, y -> x-y end)
        {Stream.take(line,-1),new_line}
      end
    end,
    fn _ -> nil end)
  end)
  |>Enum.sum()
  end

  def calc2(input) do
    list=input
    |> String.split("\n",trim: true)
    |> Stream.map(&String.split(&1," ",trim: true))
    |> Stream.map(&Enum.map(&1,fn x -> String.to_integer(x) end))
    |> Stream.map(fn list ->
    Stream.transform(list,
    fn -> {list,List.first(list)} end,

    fn _element, {line,first_el} ->
      if( Stream.drop(line,1)|>Enum.empty?() ||line |>Enum.all?(&(&1==0)) ) do
        {:halt,0}
      else
        new_line = Stream.zip_with(Stream.drop(line,1),line, fn x, y -> x-y end)
        if first_el != 0, do: {[first_el],{new_line,0}}, else: {Stream.take(line,1),{new_line,0}}
      end
    end,
    fn _ -> nil end)
  end)
  |>Stream.flat_map(&Stream.chunk_every(&1,2,2,[0]))
  |>Stream.map( fn [x,y] -> x-y end)
  |>Enum.sum()


  end


end
