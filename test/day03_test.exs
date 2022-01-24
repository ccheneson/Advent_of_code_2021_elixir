defmodule Day03Test do
  use ExUnit.Case

  def input do
      """
    00100
    11110
    10110
    10111
    10101
    01111
    00111
    11100
    10000
    11001
    00010
    01010
  """
  end 

  @tag :d03p1
  test "Day03 part1" do
   
      input = Utils.string_to_list_string(input())  
      assert Day03.run01(input) == 22
      
  end

  @tag :d03p2
  test "Day03 part2" do

      input = Utils.string_to_list_string(input())  
      assert Day03.run02(input) == 230
      
  end
end
