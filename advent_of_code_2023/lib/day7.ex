defmodule Day7 do
  @value_card%{
    "A"=>14,
    "K"=>13,
    "Q"=>12,
    "J"=>11,
    "T"=>10,
    "9"=>9,
    "8"=>8,
    "7"=>7,
    "6"=>6,
    "5"=>5,
    "4"=>4,
    "3"=>3,
    "2"=>2,
  }
  @value_card_part2%{
    "A"=>14,
    "K"=>13,
    "Q"=>12,
    "T"=>10,
    "9"=>9,
    "8"=>8,
    "7"=>7,
    "6"=>6,
    "5"=>5,
    "4"=>4,
    "3"=>3,
    "2"=>2,
    "J"=>1,
  }
  def calc(input) do
    input
    |> String.split(["\n"," "],trim: true)
    |>Enum.chunk_every(2)
    |>Map.new(fn [hand, bid]->
      {hand, String.to_integer(bid)}
    end)
    |> Enum.sort(&compare_type/2)
    |> Enum.with_index(fn {_hand,bid},index-> bid*(index+1) end)
    |> Enum.sum()
  end

  def compare_type({hand1,_},{hand2,_}) do
    case better_hand?(hand1,hand2) do
       0 -> comparer_hand(String.codepoints(hand1),String.codepoints(hand2))
      result->result
    end
  end
  def comparer_hand([head1| tail1],[head2| tail2]), do:  compare_hand({@value_card[head1], tail1},{@value_card[head2],tail2})
  def compare_hand({head1, tail1},{head2, tail2}) when head1==head2, do: comparer_hand(tail1,tail2)
  def compare_hand({head1, _tail1},{head2, _tail2}) when head1 != head2, do: head2>head1
  def better_hand?(hand1,hand2) do
    val1=which_hand?(hand1)
    val2=which_hand?(hand2)
    cond do
      val1>val2 ->false
      val1<val2 -> true
      true -> 0
    end
  end

  def which_hand?(word) do
    word
    |> String.graphemes
    |> Enum.frequencies()
    |> Enum.reduce({0,1},fn {_card,number}, {number_uniq_card,helper_number}->
      {number_uniq_card+1,helper_number*number}
    end)
    |>type_of_hand()
  end

  def type_of_hand({number_of_uniq_card,_help_number}) when number_of_uniq_card==1, do: 7
  def type_of_hand({number_of_uniq_card,_help_number}) when number_of_uniq_card==4, do: 2
  def type_of_hand({number_of_uniq_card,_help_number}) when number_of_uniq_card==5, do: 1
  def type_of_hand({number_of_uniq_card,help_number}) when number_of_uniq_card==3 and help_number==3, do: 4
  def type_of_hand({number_of_uniq_card,help_number}) when number_of_uniq_card==3 and help_number==4, do: 3
  def type_of_hand({number_of_uniq_card,help_number}) when number_of_uniq_card==2 and help_number==6, do: 5
  def type_of_hand({number_of_uniq_card,help_number}) when number_of_uniq_card==2 and help_number==4, do: 6




  ###################Part 2##############
  def calc2(input) do
    input
    |> String.split(["\n"," "],trim: true)
    |>Enum.chunk_every(2)
    |>Map.new(fn [hand, bid]->
      {hand, String.to_integer(bid)}
    end)
    |> Enum.sort(&sorter_type/2)
    |> Enum.with_index(fn {_hand,bid},index-> bid*(index+1) end)
    |> Enum.sum()
  end

  def sorter_type({hand1,_},{hand2,_}) do
    case better_hand2?(hand1,hand2) do
       0 -> comparer_hand2(String.codepoints(hand1),String.codepoints(hand2))
      result->result
    end
  end

  def better_hand2?(hand1,hand2) do
    val1=power_of_hand(hand1)
    val2=power_of_hand(hand2)
    cond do
      val1>val2 ->false
      val1<val2 -> true
      true -> 0
    end
  end
  def comparer_hand2([head1| tail1],[head2| tail2]) do
    compare_hand2({@value_card_part2[head1], tail1},{@value_card_part2[head2],tail2})
  end
  def compare_hand2({head1, _tail1},{head2, _tail2}) when head1>head2 do
    false
  end
  def compare_hand2({head1, _tail1},{head2, _tail2}) when head1<head2 do
    true
  end
  def compare_hand2({head1, tail1},{head2, tail2}) when head1==head2 do
    comparer_hand2(tail1,tail2)
  end
  def power_of_hand(hand) do
    if String.contains?(hand,"J") do
      which_hand2_J?(hand)
    else
      which_hand2?(hand)
    end
  end

  def which_hand2?(word) do
    word
    |> String.graphemes
    |> Enum.frequencies()
    |> Enum.reduce({0,1},fn {_card,number}, {number_uniq_card,helper_number}->
      {number_uniq_card+1,helper_number*number}
    end)
    |>type_of_hand2()
  end
  def which_hand2_J?(word) do
    list_card=word
    |> String.graphemes
    |> Enum.frequencies()
    [list_card["J"]|Enum.reduce(list_card,[-1,1],fn {_card,number}, [number_uniq_card,helper_number]->
     [number_uniq_card+1,helper_number*number]
    end)]
    |> type_of_hand2_J()
  end


  def type_of_hand2_J([_num_J,num_uniq,_helper_num]) when num_uniq==1, do: 7
  def type_of_hand2_J([num_J,_num_uniq,_helper_num]) when num_J==5, do: 7
  def type_of_hand2_J([num_J,num_uniq,helper_num]) when num_uniq==2 and num_J==1 and helper_num==4 , do: 5
  def type_of_hand2_J([_num_J,num_uniq,_helper_num]) when num_uniq==2, do: 6
  def type_of_hand2_J([_num_J,num_uniq,_helper_num]) when num_uniq==3, do: 4
  def type_of_hand2_J([_num_J,num_uniq,_helper_num]) when num_uniq==4, do: 2
  def type_of_hand2({number_of_uniq_card,_help_number}) when number_of_uniq_card==1, do: 7
  def type_of_hand2({number_of_uniq_card,_help_number}) when number_of_uniq_card==4, do: 2
  def type_of_hand2({number_of_uniq_card,_help_number}) when number_of_uniq_card==5, do: 1
  def type_of_hand2({number_of_uniq_card,help_number}) when number_of_uniq_card==3 and help_number==3, do: 4
  def type_of_hand2({number_of_uniq_card,help_number}) when number_of_uniq_card==3 and help_number==4, do: 3
  def type_of_hand2({number_of_uniq_card,help_number}) when number_of_uniq_card==2 and help_number==6, do: 5
  def type_of_hand2({number_of_uniq_card,help_number}) when number_of_uniq_card==2 and help_number==4, do: 6

end
