defmodule Day7Test do
  use ExUnit.Case

  test "scenario 1" do
    given = """
    32T3K 765
    T55J5 684
    KK677 28
    KTJJT 220
    QQQJA 483
    """

    result = Day7.calc(given)

    assert result == 6440
  end
  test "scenario 1 part 2" do
    given = """
    32T3K 765
    T55J5 684
    KK677 28
    KTJJT 220
    QQQJA 483
    """

    result = Day7.calc2(given)

    assert result == 5905
  end
end
