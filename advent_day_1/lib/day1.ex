defmodule Day1 do
  alias DataAdvent, as: Data

  def sum() do
    Data.get_data_1()
    |> Stream.map(&find_number(&1))
    |> Stream.map(&take_sum(&1))
    |> Enum.sum()
  end

  def find_number(word) do
    word
    |> String.graphemes()
    |> Stream.map(fn x ->
      case Integer.parse(x) do
        {number, ""} -> number
        _ -> nil
      end
    end)
    |> Enum.reject(&is_nil/1)
  end

  def take_sum(list) do
    List.first(list) * 10 + List.last(list)
  end

  def solution_2() do
    Data.get_data_1()
    |> Stream.map(fn x -> Regex.scan(~r/[0-9]{1}/, x) end)
    |> Stream.map(fn x -> {List.first(x), List.last(x)} end)
    |> Stream.map(fn {x, y} -> "#{x}#{y}" end)
    |> Stream.map(fn x -> String.to_integer(x) end)
    |> Enum.sum()
  end

  @mapper %{
    "one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9"
  }
  def solution_2_part2() do
    Data.get_data_1()
    |> Enum.map(fn x ->
      Regex.scan(~r/[(one|two|three|four|five|six|seven|eight|nine)|[0-9]]{1}/, x)
    end)
    |> Stream.map(fn x -> {List.first(x), List.last(x)} end)
    |> Enum.map(fn {x, y} ->
      IO.puts(x)
      x = if length(x) > 1, do: @mapper[x], else: x
      y = if length(y) > 1, do: @mapper[y], else: y
      {x, y}
    end)
    |> IO.inspect()
    |> Stream.map(fn {x, y} -> "#{x}#{y}" end)
    |> Stream.map(fn x -> String.to_integer(x) end)
    |> Enum.sum()
  end

  # Part two

  def sum_part_2() do
    words = Data.get_data_1()

    a =
      words
      |> find_1_digits()

    b =
      words
      |> find_2_digits()

    a * 10 + b
  end

  def find_1_digits(words) do
    words
    |> Enum.map(&convert_word_1(&1))
    |> Enum.map(&find_number(&1))
    |> Enum.map(&List.first(&1))
    |> Enum.sum()
  end

  def find_2_digits(words) do
    words
    |> Enum.map(&String.reverse(&1))
    |> Enum.map(&convert_word_2(&1))
    |> Enum.map(&find_number(&1))
    |> Enum.map(&List.first(&1))
    |> Enum.sum()
  end

  defp convert_word_1(word) do
    digits_1 = %{
      "one" => "1",
      "two" => "2",
      "three" => "3",
      "four" => "4",
      "five" => "5",
      "six" => "6",
      "seven" => "7",
      "eight" => "8",
      "nine" => "9"
    }

    list_1 = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    String.replace(word, list_1, &Map.get(digits_1, &1))
  end

  defp convert_word_2(word) do
    digits_1 = %{
      "one" => "1",
      "two" => "2",
      "three" => "3",
      "four" => "4",
      "five" => "5",
      "six" => "6",
      "seven" => "7",
      "eight" => "8",
      "nine" => "9"
    }

    digits_2 =
      digits_1
      |> Map.new(fn {key, val} -> {String.reverse(key), val} end)

    list_1 = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

    list_2 =
      list_1
      |> Enum.map(&String.reverse(&1))

    String.replace(word, list_2, &Map.get(digits_2, &1))
  end
end
