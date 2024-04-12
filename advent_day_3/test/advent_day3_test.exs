defmodule AdventDay3Test do
  use ExUnit.Case
  doctest Engine

  test "check suranding 1" do
    data=["..123..",
          "..2*...",
          "..12..."]
    id = Engine.find_index_symbol(data,1)
    assert Engine.sum_surranding(id,data,1) == ["yes","left","lefter"]
  end

  test "check suranding 2" do
    data=[".......",
          "...*...",
          "......."]
    id = Engine.find_index_symbol(data,1)
    assert Engine.sum_surranding(id,data,1) == ["no","no","no"]
  end

  test "check suranding 3" do
    data=["..1.3..",
          "...*...",
          "..123.."]
    id = Engine.find_index_symbol(data,1)
    assert Engine.sum_surranding(id,data,1) == ["left right","no","yes"]
  end

  test "check suranding 4" do
    data=["..1.3..",
          "...*...",
          ]
    id = Engine.find_index_symbol(data,1)
    assert Engine.sum_surranding(id,data,1) == ["left right","no","no lower row"]
  end
  test "check suranding 5" do
    data=["..1*3..",
          "...*...",
          "..123.."]
    id = Engine.find_index_symbol(data,0)
    assert Engine.sum_surranding(id,data,0) == ["no uper row","left right","no"]
  end
  test "check suranding 6" do
    data=["..1*3..",
          ".......",
          "..123.."]
    id = Engine.find_index_symbol(data,0)
    assert Engine.sum_surranding(id,data,0) == ["no uper row","left right","no"]
  end
end
