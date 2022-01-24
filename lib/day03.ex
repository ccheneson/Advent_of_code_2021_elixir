defmodule Day03 do


  def calculate_rating(list, fnc) do
      { z, o } = 
            list
            |> List.foldl({0,0}, fn x, acc -> 
                if x == "0" do
                    {zcount, _} = acc
                    put_elem(acc, 0, zcount + 1)
                else
                    {_, ocount} = acc
                    put_elem(acc, 1, ocount + 1)
                end
            end)
       fnc.(z,o)
  end

  def binary_rep_to_dec(s) do
    Integer.parse(s, 2) |> elem(0)
  end
 

  def run01(input) do
    input = input     
        |> Enum.map(fn x -> String.trim(x) end)
        |> Enum.map(fn x -> String.split(x, "", trim: true) end)
    
    #https://stackoverflow.com/questions/23705074/is-there-a-transpose-function-in-elixir
    flip = Enum.zip_with(input, & &1)    
    gama_fnc = fn (z,o) -> if z > o do "0" else "1"  end end
    gama_bits = Enum.map(flip, fn x -> calculate_rating(x, gama_fnc) end)
    binary_rep_to_dec(Enum.join(gama_bits))
  end

  def process02(result, _, _) when length(result) == 1 do
    Enum.at(result, 0)
  end

  def process02(input, from, fnc) do
    flip_row = Enum.zip_with(input, & &1) |> Enum.at(from)
    rating = calculate_rating(flip_row, fnc)
    new_input = Enum.filter(input, fn x -> Enum.at(x,from) == rating end)
    process02(new_input, from + 1, fnc)
  end

  def run02(input) do
    input = input     
        |> Enum.map(fn x -> String.trim(x) end)
        |> Enum.map(fn x -> String.split(x, "", trim: true) end)
    
    oxygen_generator = fn (z,o) -> if o >= z do "1" else "0"  end end
    co2_scrubber = fn (z,o) -> if o >= z do "0" else "1"  end end


    base_ogr = process02(input, 0, oxygen_generator)
    base_csr = process02(input, 0, co2_scrubber)

    base_ogr_dec = binary_rep_to_dec(Enum.join(base_ogr,""))
    base_csr_dec = binary_rep_to_dec(Enum.join(base_csr,""))
    base_ogr_dec * base_csr_dec
 end

end


