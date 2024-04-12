defmodule DataSorter.EngineData do

  def simplifyer do
    patern=find_symbols()
    DataAdvent.get_data_3
    |> Enum.map(&(String.replace(&1,patern,"*")))
  end

  def find_symbols do
    DataAdvent.get_data_3
    |> Enum.map(&(String.graphemes(&1)))
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.filter(&(filter_symbol(&1)))
  end

  def filter_symbol(symbol) do
    code_points= symbol
    |> String.to_charlist()
    |> hd()
    if ((code_points>47 && code_points<59)||symbol==".") do
      false
    else
      true
    end
  end

end
