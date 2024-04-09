defmodule Day1 do
alias DataAdvent, as: Data
  def sum() do
    Data.get_data()
    |> Enum.map(&(find_number(&1)))
    |> Enum.map(&(take_sum(&1)))
    |> Enum.sum()
  end

  def find_number(word) do
    String.graphemes(word)
    |> Enum.map(fn x ->
      case try_convert(x) do
        :ok -> nil
        val -> val
      end
    end)
    |> Enum.reject(&(&1==nil))
  end

  def take_sum(list) do
    List.first(list)*10+List.last(list)
  end

  defp try_convert(string) do
    try do
      String.to_integer(string)
     rescue
      ArgumentError -> :ok
     catch
       val-> val
     end
  end
  #Part two

  def sum_part_2() do
    words=Data.get_data()
    a=words
    |>find_1_digits()
    b=words
    |> find_2_digits()
    a*10+b
  end
  def find_1_digits(words) do
    words
    |> Enum.map(&(convert_word_1(&1)))
    |> Enum.map(&(find_number(&1)))
    |> Enum.map(&(List.first(&1)))
    |> Enum.sum()
  end

  def find_2_digits(words) do
    words
    |>Enum.map(&(String.reverse(&1)))
    |> Enum.map(&(convert_word_2(&1)))
    |> Enum.map(&(find_number(&1)))
    |> Enum.map(&(List.first(&1)))
    |> Enum.sum()
  end



  defp convert_word_1(word) do
    digits_1 = %{"one"=>"1","two"=>"2","three"=>"3","four"=>"4","five"=>"5","six"=>"6","seven"=>"7","eight"=>"8","nine"=>"9"}
    list_1 = ["one","two","three","four","five","six","seven","eight","nine"]
    String.replace(word,list_1,&Map.get(digits_1,&1))
  end

  defp convert_word_2(word) do
    digits_1 = %{"one"=>"1","two"=>"2","three"=>"3","four"=>"4","five"=>"5","six"=>"6","seven"=>"7","eight"=>"8","nine"=>"9"}
    digits_2 = digits_1
    |> Map.new(fn {key,val} -> {String.reverse(key),val} end)
    list_1 = ["one","two","three","four","five","six","seven","eight","nine"]
    list_2 = list_1
    |> Enum.map(&(String.reverse(&1)))
    String.replace(word,list_2,&Map.get(digits_2,&1))
  end

end
