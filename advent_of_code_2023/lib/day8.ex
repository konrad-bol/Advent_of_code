defmodule Day8 do

  def calc(input) do
    [order | direction]=input
    |> String.split("\n",trim: true)
    direction=direction
    |>Map.new(fn line ->
        [at,target]= line
        |> String.replace(["(",")",", "],"")
        |> String.split(" = ")
        {at,String.split_at(target,3)}
    end)
    order
    |> String.split("",trim: true)
    |> IO.inspect()
    |> Stream.cycle()
    |> Stream.transform("AAA", fn turn, at ->
      if at=="ZZZ", do: {:halt,at}, else: {[turn],next_place(at,direction,turn)}
    end)
    |> Enum.to_list()
    |> length()
  end

  def next_place(at,map,inst) do
    select_path(inst,map[at])
  end

  def select_path(turn, {left,_right}) when turn=="L", do: left
  def select_path(turn, {_left,right}) when turn=="R", do: right


##################### PART 2 ##################
  def calc2(input) do

    [order | direction]=input
    |> String.split("\n",trim: true)
    direction=direction
    |>Map.new(fn line ->
        [at,target]= line
        |> String.replace(["(",")",", "],"")
        |> String.split(" = ")
        {at,String.split_at(target,3)}
    end)

    direction
    |>Map.filter( fn {place,_}->String.ends_with?(place,"A") end)
    |>Map.keys()
    |>Enum.reduce(1,fn start, acc ->
    order
    |> String.split("",trim: true)
    |> Stream.cycle()
    |> Stream.transform(start, fn turn, at ->
      if String.ends_with?(at,"Z"), do: {:halt,at}, else: {[turn],next_place2(at,direction,turn)}
    end)
    |> Enum.to_list()
    |> length()
    |> nww(acc)
    end)

  end
  def nww(int1,int2) do
  int1*int2/Integer.gcd(int1,int2)
  |> round
  end

  def next_place2(at,map,inst) do
    select_path(inst,map[at])
  end

  def select_path2(turn, {left,_right}) when turn=="L", do: left
  def select_path2(turn, {_left,right}) when turn=="R", do: right

end
