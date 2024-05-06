defmodule Day7 do
  @value_card %{"A"=>14,"K"=>13,"Q"=>12,"J"=>11,"T"=>10,"9"=>9,"8"=>8,"7"=>7,"6"=>6,"5"=>5,"4"=>4,"3"=>3,"2"=>2}
  @value_card_part2%{"A"=>14,"K"=>13,"Q"=>12,"T"=>10,"9"=>9,"8"=>8,"7"=>7,"6"=>6,"5"=>5,"4"=>4,"3"=>3,"2"=>2,"J"=>1}

  def calc(input) do
    input
    |> String.split(["\n"," "],trim: true)
    |> Enum.chunk_every(2)
    |> Enum.sort(&compare_type/2)
    |> Enum.with_index(&(String.to_integer(List.last(&1))*(&2+1)))
    |> Enum.sum()
  end

  defp compare_type([hand1,_],[hand2,_]) do
    case better_hand?(hand1,hand2) do
      0      -> comparer_hand(String.codepoints(hand1),String.codepoints(hand2))
      result -> result
    end
  end
  defp comparer_hand([head1| tail1], [head2| tail2]), do:  compare_hand({@value_card[head1], tail1},{@value_card[head2],tail2})

  defp compare_hand({head1, tail1}, {head2, tail2})   when head1 == head2, do: comparer_hand(tail1,tail2)
  defp compare_hand({head1, _tail1}, {head2, _tail2}) when head1 != head2, do: head2 > head1

  def better_hand?(hand1,hand2) do
    power_first_hand  = power_of_hand(hand1)
    power_second_hand = power_of_hand(hand2)
    cond do
      power_first_hand > power_second_hand -> false
      power_first_hand < power_second_hand -> true
      true        -> 0
    end
  end

  def power_of_hand(hand) do
    hand
    |> String.graphemes
    |> Enum.frequencies()
    |> Enum.reduce({0,1},&{elem(&2,0)+1,elem(&2,1)*elem(&1,1)})
    |> type_of_hand()
  end

  defp type_of_hand({number_of_uniq_card,_help_number}) when number_of_uniq_card==1, do: 7
  defp type_of_hand({number_of_uniq_card,_help_number}) when number_of_uniq_card==4, do: 2
  defp type_of_hand({number_of_uniq_card,_help_number}) when number_of_uniq_card==5, do: 1
  defp type_of_hand({number_of_uniq_card,help_number})  when number_of_uniq_card==3 and help_number==3, do: 4
  defp type_of_hand({number_of_uniq_card,help_number})  when number_of_uniq_card==3 and help_number==4, do: 3
  defp type_of_hand({number_of_uniq_card,help_number})  when number_of_uniq_card==2 and help_number==6, do: 5
  defp type_of_hand({number_of_uniq_card,help_number})  when number_of_uniq_card==2 and help_number==4, do: 6




  ###p ###############Part 2##################################################################
  def calc2(input) do
    input
    |> String.split(["\n"," "],trim: true)
    |> Enum.chunk_every(2)
    |> Enum.sort(&sorter_type/2)
    |> Enum.with_index(&(String.to_integer(List.last(&1))*(&2+1)))
    |> Enum.sum()
  end

  defp  sorter_type([hand1,_],[hand2,_]) do
    case better_hand2?(hand1,hand2) do
      0       -> comparer_hand2(String.codepoints(hand1),String.codepoints(hand2))
      result  -> result
    end
  end
  defp comparer_hand2([head1| tail1], [head2| tail2]), do:  compare_hand2({@value_card_part2[head1], tail1},{@value_card_part2[head2],tail2})

  defp compare_hand2({head1, tail1}, {head2, tail2})   when head1 == head2, do: comparer_hand2(tail1,tail2)
  defp compare_hand2({head1, _tail1}, {head2, _tail2}) when head1 != head2, do: head2>head1

  def better_hand2?(hand1,hand2) do
    power_first_hand  = power_of_hand2(hand1)
    power_second_hand = power_of_hand2(hand2)
    cond do
      power_first_hand > power_second_hand -> false
      power_first_hand < power_second_hand -> true
      true        -> 0
    end
  end

  def power_of_hand2(hand) do
    case String.contains?(hand,"J") do
       true  -> power_of_hand_with_J(hand)
       false -> power_of_hand_without_J(hand)
    end
  end

  def power_of_hand_without_J(hand) do
    hand
    |> String.graphemes
    |> Enum.frequencies()
    |> Enum.reduce({0,1},&{elem(&2,0)+1,elem(&2,1)*elem(&1,1)})
    |> type_of_hand2()
  end

  def power_of_hand_with_J(hand) do
    hand
    |> String.graphemes
    |> Enum.frequencies()
    |> power_combine_helper()
    |> type_of_hand2_J()
  end

  defp power_combine_helper(list_card), do: [list_card["J"] | power_helper(list_card)]
  defp power_helper(list) do
    list
    |> Enum.reduce([-1,1], &([List.first(&2)+1, List.last(&2)*elem(&1,1)]))
  end

  defp type_of_hand2_J([num_J,num_uniq,helper_num])      when num_uniq==2 and num_J==1 and helper_num==4 , do: 5
  defp type_of_hand2_J([num_J,_num_uniq,_helper_num])    when num_J==5, do: 7
  defp type_of_hand2_J([_num_J,num_uniq,_helper_num])    when num_uniq==1, do: 7
  defp type_of_hand2_J([_num_J,num_uniq,_helper_num])    when num_uniq==2, do: 6
  defp type_of_hand2_J([_num_J,num_uniq,_helper_num])    when num_uniq==3, do: 4
  defp type_of_hand2_J([_num_J,num_uniq,_helper_num])    when num_uniq==4, do: 2


  defp type_of_hand2({number_of_uniq_card,_help_number}) when number_of_uniq_card==1, do: 7
  defp type_of_hand2({number_of_uniq_card,_help_number}) when number_of_uniq_card==4, do: 2
  defp type_of_hand2({number_of_uniq_card,_help_number}) when number_of_uniq_card==5, do: 1
  defp type_of_hand2({number_of_uniq_card,help_number})  when number_of_uniq_card==3 and help_number==3, do: 4
  defp type_of_hand2({number_of_uniq_card,help_number})  when number_of_uniq_card==3 and help_number==4, do: 3
  defp type_of_hand2({number_of_uniq_card,help_number})  when number_of_uniq_card==2 and help_number==6, do: 5
  defp type_of_hand2({number_of_uniq_card,help_number})  when number_of_uniq_card==2 and help_number==4, do: 6


end
