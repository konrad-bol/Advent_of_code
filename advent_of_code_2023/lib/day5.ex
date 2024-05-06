defmodule Day5 do

  def calc(input) do
    input=input |> String.split(["seeds:","seed-to-soil map:","soil-to-fertilizer map:","fertilizer-to-water map:","water-to-light map:","light-to-temperature map:","temperature-to-humidity map:","humidity-to-location map:"],trim: true)
    |> Enum.map(&String.split(&1,"\n",trim: true))
    #|>IO.inspect()
    map= input
    |> tl()
    |>Enum.map(&convert_map(&1))

    input
    |>hd()|>hd()
    |>String.split(" ",trim: true)
    |>Enum.map(&String.to_integer&1)


    |> Enum.map(&convert_seed2(&1,map))
    |>Enum.min()
  end
  def convert_map(list_of_map) do
    list_of_map
    |>Stream.map(&String.split(&1, " "))
    |>Stream.map(&Enum.map(&1, fn x -> String.to_integer(x)end))
    |>Enum.sort(&(Enum.at(&1,1)<Enum.at(&2,1)))
    #|>IO.inspect()
  end
  def convert_seed2(num,maps) do
    maps
    |>Enum.reduce(num, fn level, acc ->
       Enum.reduce_while(level,acc, fn [x,y,z], _ans ->

        if(acc in y..(y+z-1)) do
          {:halt,acc+x-y}
        else
          {:cont, acc }
        end
        end)
    end)
  end
  def calc2(input) do
    input=input |> String.split(["seeds:","seed-to-soil map:","soil-to-fertilizer map:","fertilizer-to-water map:","water-to-light map:","light-to-temperature map:","temperature-to-humidity map:","humidity-to-location map:"],trim: true)
    |> Enum.map(&String.split(&1,"\n",trim: true))

    map= input
    |> tl()
    |>Stream.map(&convert_map(&1))
    |>Enum.to_list()
    |>IO.inspect()
     _seed=input
    |>hd()|>hd()
    |>String.split(" ",trim: true)
    |>Enum.map(&String.to_integer&1)
    |>Enum.chunk_every(2)
    |>Enum.to_list()
    |>Enum.reduce( 0,fn [_,a], acc ->
      acc+a
    end)
    |>IO.inspect()

     find_seed([1, 100],map)


  end
  def find_seed([start,len],maps) do
    [{_,ans}]=
      Stream.unfold({start, nil}, fn
      {n, nil} when n <= start + len - 1 ->
        {{n, nil}, {n + 1,convert_seed2(n,maps)}}
      {n, min} when n <= start + len - 1 ->
        {{n, min}, {n + 1,
        case convert_seed2(n,maps) do
          x when x<min ->x
            _-> min
        end}}
      _ -> nil
    end)
    |>Stream.take(-1)
    |>Enum.to_list()
    IO.inspect(ans)
    ans
end
  def test1([start,len]) do
     [{_,ans}]= Stream.unfold({start, nil}, fn
        {n, nil} when n <= start + len - 1 ->
          {{n, nil}, {n + 1,
            if(is_prime(n)!=0) do
            n
            else
            nil
            end}}
        {n, max} when n <= start + len - 1 ->
          {{n, max}, {n + 1,
          if(is_prime(n)>max) do
           n
          else
           max
          end}}
        _ ->
          nil
      end)
      |>Stream.take(-1)
      |>Enum.to_list()
      ans
  end
  def is_prime(num) do
    2..(trunc(:math.sqrt(num)))
    |>Enum.to_list()
    |>Enum.all?(fn x ->
      rem(num,x)!=0
    end)
    |>is_prime(num)
  end
  def is_prime(true,num), do: num
  def is_prime(false,_num), do: 0


end
