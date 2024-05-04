defmodule Day3 do
  def calc(input) do
    input = input |> String.split("\n", trim: true) |> Enum.with_index()

    symbols =
      Enum.reduce(input, %{}, fn {line, index}, acc ->
        value =
          line
          |> String.graphemes()
          |> Enum.with_index()
          |> Enum.reject(fn {char, _i} ->
            String.contains?(char, ".") or Regex.match?(~r/[0-9]/, char)
          end)
          |> Enum.map(fn {_, i} -> i end)

        Map.put(acc, index, value)
      end)
    input
    |> Enum.reduce(0, fn {line, index}, acc ->
      up = symbols[index - 1] || []
      down = symbols[index + 1] || []
      current = symbols[index] || []
      symbols = Enum.uniq(up ++ down ++ current)

      numbers = Regex.scan(~r/[0-9]+/, line, return: :index, capture: :first) |> List.flatten()
      s =
        numbers
        |> Enum.filter(fn {x, y} ->
          y = y + x - 1
          range = x..y
          Enum.any?(symbols, fn s -> s in range || (s - 1) in range || (s+1)  in range end)
        end)
        |> Enum.map(fn {x, y} ->
          String.slice(line, x, y)
        end)
        |> Enum.map(&String.to_integer/1)
        |> Enum.sum()

      s + acc
    end)
  end

  def calc2(input) do
    input = input |> String.split("\n", trim: true) |> Enum.with_index()

          symbols =
            Enum.reduce(input, %{}, fn {line, index}, acc ->
              value =
                line
                |> String.graphemes()
                |> Enum.with_index()
                |> Enum.filter(fn {char, _i} ->
                  String.contains?(char, "*")
                end)
                |> Enum.map(fn {_, i} -> i end)
              Map.put(acc, index, value)
            end)

            numbers=
              Enum.reduce(input,%{}, fn {line,index}, acc ->
                positon=
                  Regex.scan(~r/[0-9]+/, line, return: :index, capture: :first) |> List.flatten()
                  Map.put(acc,index,positon)
              end)

      Enum.reduce(symbols,0, fn {index_line,index_symbol}, acc ->
        up = numbers[index_line - 1] || []
        down = numbers[index_line + 1] || []
        current = numbers[index_line] || []


          n=if !Enum.empty?(index_symbol) do
              Enum.map(index_symbol, fn index ->
                up_number=Enum.filter(up, fn {x,y} ->
                  y=x+y-1
                  range = x..y
                  index in range || (index - 1) in range || (index+1)  in range
                end)

                down_number=Enum.filter(down, fn {x,y} ->
                  y=x+y-1
                  range = x..y
                  index in range || (index - 1) in range || (index+1)  in range
                end)

                current_number=Enum.filter(current, fn {x,y} ->
                  y=x+y-1
                  range = x..y
                  index in range || (index - 1) in range || (index+1)  in range
                end)


            if((length(current_number)+length(up_number)+length(down_number)) >1) do
                n1 =
                      if index_line>=1 do
                      take_number(Enum.at(input,index_line-1),up_number)
                      else
                      []
                      end

              n2=take_number(Enum.at(input,index_line+1),down_number)
              n3=take_number(Enum.at(input,index_line),current_number)
              n1++n2++n3
              |>List.flatten()
              |> Enum.product()
            else
              0
            end
          end)
        else
          0
        end
        ans=if is_list(n) do
         Enum.sum(n)
        else
          0
        end
        IO.inspect(ans)
        acc+ans
      end)
  end

  def take_number({line,_id},list_of_start) do
    Enum.map(list_of_start, fn {x,y} ->
      String.slice(line,x,y)
    end)
    |>Enum.map(&String.to_integer&1)
  end
end
