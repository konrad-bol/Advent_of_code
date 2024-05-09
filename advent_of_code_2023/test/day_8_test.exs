defmodule Day8Test do
  use ExUnit.Case

  test "scenario 1" do
    given = """
    RL

    AAA = (BBB, CCC)
    BBB = (DDD, EEE)
    CCC = (ZZZ, GGG)
    DDD = (DDD, DDD)
    EEE = (EEE, EEE)
    GGG = (GGG, GGG)
    ZZZ = (ZZZ, ZZZ)
    """

    result = Day8.calc(given)

    assert result == 2
  end
  test "scenario 2 " do
    given = """
    LLR

    AAA = (BBB, BBB)
    BBB = (AAA, ZZZ)
    ZZZ = (ZZZ, ZZZ)
    """

    result = Day8.calc(given)

    assert result == 6
  end
end
