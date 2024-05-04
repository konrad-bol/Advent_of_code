defmodule Day3Test do
  use ExUnit.Case

  test "scenario 1" do
    given = """
    467..114..
    ..*......*
    35....633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """

    result = Day3.calc(given)

    assert result == 4361
  end
  test "scenario 1 part 2" do
    given = """
    467..114..
    ..*......*
    35....633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """

    result = Day3.calc2(given)

    assert result == 467835
  end
end
