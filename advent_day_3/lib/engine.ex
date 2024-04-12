defmodule Engine do
  alias DataSorter.EngineData
  def sum_of_parts() do
    EngineData.simplifyer
    |> sum_of_parts(0,0)
  end
  def sum_of_parts(data,row_id,sum) do
    sum1 = Enum.at(data,row_id)
    |> String.contains?("*")
    |> if do
      find_index_symbol(data,row_id)
      |> sum_surranding(data,row_id)
    end
      #sum_of_parts(data,row_id+1,sum)
    sum1
  end


  def sum_surranding(symbol_id,data,row_id) do
    mid_pos =
      Enum.at(data,row_id)
      |>take_part(symbol_id)
      |> case  do
        [".",".","."] -> 0
        [_a,".","."]  -> take_number(Enum.at(data,row_id),symbol_id,:left)
        [".",".",_b]  -> take_number(Enum.at(data,row_id),symbol_id,:right)
        [_a,".",_b]   -> take_number(Enum.at(data,row_id),symbol_id,:left) ++ take_number(Enum.at(data,row_id),symbol_id,:right)
      end

    uper_pos=
      case {Enum.at(data,row_id-1) |>take_part(symbol_id),row_id} do
        {_,0} ->"no uper row"
        {[".",".","."],_} -> "no"
        {[_a,".","."],_}  -> "left"
        {[_a,_a1,"."],_}  -> "lefter"
        {[".",".",_b],_}  -> "right"
        {[".",_b1,_b],_}  -> "righter"
        {[_a,".",_b],_}   -> "left right"
        {[_a,_b,_c],_}    -> "yes"
      end
     lower_pos=
      Enum.at(data,row_id+1)
      |>take_part(symbol_id)
      |> case  do
      nil ->"no lower row"
      [".",".","."] -> "no"
      [_a,".","."]  -> "left"
      [_a,_a1,"."]  -> "lefter"
      [".",".",_b]  -> "right"
      [".",_b1,_b]  -> "righter"
      [_a,".",_b]   -> "left righr"
      [_a,_b,_c]    -> "yes"
   end
   [uper_pos,mid_pos,lower_pos]
  end

  def find_index_symbol(data,row_id) do
    case String.split(Enum.at(data,row_id), "*", parts: 2) do
      [left, _] -> String.length(left)
      [_] -> nil
    end
  end

  def take_part(nil,id), do: nil
  def take_part(line,0), do: "."<>String.slice(line,0,2)|> String.replace("*",".") |>String.codepoints()
  def take_part(line,id), do: String.slice(line,id-1,3)|>String.pad_trailing(3,".")|> String.replace("*",".") |>String.codepoints()

  def take_number(line, start, :right) do
    {left, right} =
      String.split_at(line,start+1)
      [x,y]= right
      |> Integer.parse()
      |> Tuple.to_list()
      [left,x,y]
  end
  def take_number(line, start, :left) do
    {left, right} =
      String.split_at(line,start)
      [x,y] = left
      |> String.reverse()
      |> Integer.parse()
      |> Tuple.to_list()
      [String.reverse(y),Integer.to_string(x)|> String.reverse()|>String.to_integer() ,right]

  end
  def take_number(line,start,:middle) do
    [left,num_left,_]   = take_number(line,start,:left)
    [_,num_right,right] = take_number(line,start-1,:right)
    num=Integer.digits(num_left) ++ Integer.digits(num_right)
    |>Integer.undigits()
    [left,num,right]
  end
  def update_line(numbers,parts=[left_part,right_part]) do
    [len_l,len_r]= Enum.map(parts,&String.length&1)
    [num_left,num_right]=numbers
    |> Enum.map(fn x ->
      if(is_number(x)) do
        Integer.to_string(x)
      else
        ""
      end
    end)
    [line_left,line_right]=[String.replace_suffix(left_part,num_left <> "*","")
    |> String.pad_trailing(len_l,"."),
    String.replace_prefix(right_part,num_right,"")
    |> String.pad_leading(len_r,".")]

    update_line=line_left<>line_right
  end
end
