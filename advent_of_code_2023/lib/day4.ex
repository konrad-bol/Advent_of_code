defmodule Day4 do
  def calc(input) do
    input |> String.split("\n")
    |>Enum.map(fn line -> String.split(line,[":","|"]) end)
    |>Enum.map(fn line -> tl(line) end)
    |> Enum.drop(-1)
    |>Enum.map(fn [win,number] ->
      win=String.split(win," ", trim: true)
      |> Enum.sort()
      number=String.split(number," ",trim: true)
      |>Enum.sort()
      {win,number}
    end)
    |>Enum.map(fn {win,number}->
      List.myers_difference(win,number)
      |>Enum.filter(fn {key, _val} -> key==:eq end)
      |>Enum.map(fn {_key,val} -> val end)
      |>List.flatten
    end)
    |> Enum.map(&length&1)
    |>Enum.reject(&(&1==0))
    |> Enum.reduce(0,fn power,acc ->
      acc+  Integer.pow(2,power-1)
    end)
  end

  def calc2(input) do
    input |> String.split("\n")
    |>Enum.map(fn line -> String.split(line,[":","|"]) end)
    |>Enum.map(fn line -> tl(line) end)
    #|> Enum.drop(-1)
    |>Enum.map(fn [win,number] ->
      win=String.split(win," ", trim: true)
      |> Enum.sort()
      number=String.split(number," ",trim: true)
      |>Enum.sort()
      {win,number}
    end)
    |>Enum.map(fn {win,number}->
      List.myers_difference(win,number)
      |>Enum.filter(fn {key, _val} -> key==:eq end)
      |>Enum.map(fn {_key,val} -> val end)
      |>List.flatten
    end)
    |>IO.inspect()
    |> Enum.map(&length&1)
    |>IO.inspect()
    |>Enum.map(fn wining ->
      {wining,1}
    end)
    |>calc_copy(0)
  end

  def calc_copy(data,index) do
    {copy,amount}=Enum.at(data,index)
    |>IO.inspect()
    data=update_input(data,amount,index+1,copy)
    if index<length(data)-1 do
      calc_copy(data,index+1)
    else
    IO.inspect(data)
    Enum.reduce(data,0,fn {_win,copy_amount}, acc ->
      acc+copy_amount
    end)
    end
  end
  def update_input(data,amount,start,range) do
    {left,right}= data
    |>Enum.split(start)
    {update,righter}= right
    |>Enum.split(range)
      update=Enum.map(update, fn {win,value}->
        {win,value+amount}
      end)


    left++update++righter
  end
end
