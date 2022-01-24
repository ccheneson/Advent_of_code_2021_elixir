defmodule Day02Test do
  use ExUnit.Case

  def input do
      """
    forward 5
    down 5
    forward 8
    up 3
    down 8
    forward 2
  """
  end 

  @tag :d02p1
  test "Day02 part1" do
   
      input = Utils.string_to_list_string(input())  
      assert Day02.run01(input) == 150
      
  end

  @tag :d02p2
  test "Day02 part2" do

      input = Utils.string_to_list_string(input())  
      assert Day02.run02(input) == 900
      
  end
end
