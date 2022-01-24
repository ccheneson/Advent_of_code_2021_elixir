defmodule Day01Test do
  use ExUnit.Case

  def input do
      """
    199
    200
    208
    210
    200
    207
    240
    269
    260
    263
  """
  end 

  @tag :d01p1
  test "Day01 part1" do
   
      input = Utils.string_to_list_string(input())  
      assert Day01.run01(input) == 7
      
  end

  @tag :d01p2
  test "Day01 part2" do

      input = Utils.string_to_list_string(input())  
      assert Day01.run02(input) == 5
      
  end
end
