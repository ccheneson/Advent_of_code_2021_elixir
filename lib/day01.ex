defmodule Day01 do


  def run01(input) do
    input
      |> Enum.map(fn x -> Integer.parse(String.trim(x)) |> elem(0) end)
      |> Enum.chunk_every(2,1, :discard)
      |> Enum.filter(fn [a,b] -> a < b end)
      |> Enum.count
  end
    
  def run02(input) do
    input
      |> Enum.map(fn x -> Integer.parse(String.trim(x)) |> elem(0) end)
      |> Enum.chunk_every(3,1, :discard)
      |> Enum.map(fn [a,b,c] -> a + b + c end)
      |> Enum.chunk_every(2,1, :discard)
      |> Enum.filter(fn [a,b] -> a < b end)
      |> Enum.count
  end

end


