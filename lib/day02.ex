defmodule Day02 do


  def run01(input) do
    { position, depth } = input 
      |> Enum.map(fn x -> String.split(x) end)
      |> List.foldl({0,0}, fn x, acc -> # {0,0} == {position, depth}
       {position, depth} = acc
        case x do
          ["forward", value] -> 
            v = Integer.parse(value) |> elem(0)
            put_elem(acc, 0, position + v)
          ["down", value] -> 
              v = Integer.parse(value) |> elem(0)
              put_elem(acc, 1, depth + v)
          ["up", value] -> 
                v = Integer.parse(value) |> elem(0)
                put_elem(acc, 1, depth - v)
        end
      end) 
    position * depth
  end
    
  def run02(input) do
    { position, depth, aim } = input 
    |> Enum.map(fn x -> String.split(x) end)
    |> List.foldl({0,0,0}, fn x, acc -> # {0,0,0} == {position, depth,aim}
     {position, depth, aim} = acc
      case x do
        ["forward", value] -> 
          v = Integer.parse(value) |> elem(0)
          acc = put_elem(acc, 0, position + v)
          put_elem(acc, 1, depth + aim * v)
        ["down", value] -> 
            v = Integer.parse(value) |> elem(0)
            put_elem(acc, 2, aim + v)
        ["up", value] -> 
              v = Integer.parse(value) |> elem(0)
              put_elem(acc, 2, aim - v)
      end
    end) 
  position * depth
  end

end


