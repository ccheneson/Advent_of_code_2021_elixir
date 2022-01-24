defmodule Board do
  defstruct grid: nil

  def check_boards(board, drawn_number) do
      updated = board.grid
          |> Enum.map(fn x ->                 
              Enum.map(x, fn a ->
                  if a.value === drawn_number do
                      %{a | ticked: true}
                  else
                      a
                  end
              end)
          end)
      updated_board = %{board | grid: updated }
      updated_board
  end
end

defmodule BoardBox do
  defstruct value: "", ticked: false
end

defmodule Day04Part1 do

  def verify_board_horizental(board) do
      board |> Enum.filter(fn b -> 
          Enum.all?(b, fn x -> x.ticked == true end) 
      end)
  end
  def verify_board_vertical(board) do
      board 
          |> Enum.zip_with(& &1)
          |> Enum.filter(fn b -> 
              Enum.all?(b, fn x ->
                  x.ticked == true 
              end) 
          end)
  end

  def verify_winner(boards, drawn_number) do
      boards 
          |> Enum.map(fn b -> 
              winner_h = verify_board_horizental b.grid
              winner_v = verify_board_vertical b.grid
              cond do
                  length(winner_h) == 1 ->  {:ok, drawn_number, b }
                  length(winner_v) == 1 ->  {:ok, drawn_number, b }
                  true                  ->  {:ingame, drawn_number, nil }
              end
          end) 
          |> Enum.filter(fn x ->  elem(x,0) == :ok end)
          |> Enum.at(0)
  end

  def process(_, _, {:ok, drawn_number, winner}) do
      {:ok, drawn_number, winner}
  end

  def process([], _, result) do
      result
  end


  def process(inputs, boards, _) do

      drawn_number = Enum.at(inputs, 0)   
      inputs_remaining = Enum.drop(inputs, 1)

      updated_boards = Enum.map(boards, fn b -> 
          Board.check_boards(b, drawn_number) 
      end)
      checked_winner = verify_winner(updated_boards, drawn_number)       
      process(inputs_remaining, updated_boards, checked_winner)
      
  end
  
  def parse_drawn_number(numbers) do
      numbers |> Enum.at(0)
              |> String.split(",", trim: true)
              |> Enum.map(fn x -> String.trim(x) end)
  end

  def calculate_score({:ok, drawn_number, winner}) do
      total = winner.grid
          |> List.flatten
          |> Enum.filter(fn x -> x.ticked == false end)
          |> Enum.map(fn x -> x.value end)
          |> Enum.map(fn x -> Integer.parse(x) end)
          |> Enum.map(fn x -> elem(x,0) end)
          |> Enum.sum
      
      drawn_number_int = Integer.parse(drawn_number) |> elem(0)
      total * drawn_number_int
  end

  def run(input) do
     { drawn_numbers , rest } = input |> Enum.split(1)
     drawn_numbers = parse_drawn_number(drawn_numbers)

      boards = rest 
          |> Enum.filter(fn x -> String.trim(x) != "" end)
          |> Enum.chunk_every(5)
          |> Enum.map(fn x ->                 
              Enum.map(x, fn z -> 
                  z 
                  |> String.split(" ") 
                  |> Enum.filter(fn a -> String.trim(a) != "" end)
              end)
             end)
          |> Enum.map(fn u -> #u is List[List]
              g = Enum.map(u, fn j -> # j is List
                  Enum.map(j, fn g -> %BoardBox{value: g} end)
              end)
              %Board{grid: g}
          end)
      
      winner = process(drawn_numbers, boards, nil)
      calculate_score(winner)
  end

end




defmodule Day04Part2 do

  def verify_board_horizental(board) do
      board |> Enum.filter(fn b -> 
          Enum.all?(b, fn x -> x.ticked == true end) 
      end)
  end
  def verify_board_vertical(board) do
      board 
          |> Enum.zip_with(& &1)
          |> Enum.filter(fn b -> 
              Enum.all?(b, fn x ->
                  x.ticked == true 
              end) 
          end)
  end

  def verify_winner(boards, drawn_number, winners) do
      w = boards 
          |> Enum.filter(fn b -> 
              winner_h = verify_board_horizental b.grid
              winner_v = verify_board_vertical b.grid
              cond do
                  length(winner_h) > 0 || length(winner_v) > 0   -> true
                  true                    ->  false
              end
          end)
      if length(w) == 0 do
          { boards , winners } 
      else
          still_game_boards = boards |> Enum.filter(fn x -> ! Enum.member?(w, x) end)
          new_winners = [ {drawn_number, w} |  winners]
          { still_game_boards , new_winners } 
      end
      
  end

  def process([], _, result) do
      result
  end

  def process(inputs, boards, winners) do

      drawn_number = Enum.at(inputs, 0)   
      inputs_remaining = Enum.drop(inputs, 1)

      updated_boards = Enum.map(boards, fn b -> 
          Board.check_boards(b, drawn_number) 
      end)
      { still_game_boards , new_winners } = verify_winner(updated_boards, drawn_number, winners)    
      process(inputs_remaining, still_game_boards, new_winners)
      
  end
  
  def parse_drawn_number(numbers) do
      numbers |> Enum.at(0)
              |> String.split(",", trim: true)
              |> Enum.map(fn x -> String.trim(x) end)
  end

  def calculate_score({drawn_number, winner}) do
      total = winner
          |> Enum.map(fn x -> x.grid end)
          |> List.flatten
          |> Enum.filter(fn x -> x.ticked == false end)
          |> Enum.map(fn x -> x.value end)
          |> Enum.map(fn x -> Integer.parse(x) end)
          |> Enum.map(fn x -> elem(x,0) end)
          |> Enum.sum
      
      drawn_number_int = Integer.parse(drawn_number) |> elem(0)
      total * drawn_number_int
  end

  def run(input) do
     { drawn_numbers , rest } = input |> Enum.split(1)
     drawn_numbers = parse_drawn_number(drawn_numbers)

      boards = rest 
          |> Enum.filter(fn x -> String.trim(x) != "" end)
          |> Enum.chunk_every(5)
          |> Enum.map(fn x ->                 
              Enum.map(x, fn z -> 
                  z 
                  |> String.split(" ") 
                  |> Enum.filter(fn a -> String.trim(a) != "" end)
              end)
             end)
          |> Enum.map(fn u -> #u is List[List]
              g = Enum.map(u, fn j -> # j is List
                  Enum.map(j, fn g -> %BoardBox{value: g} end)
              end)
              %Board{grid: g}
          end)
      
      winner = process(drawn_numbers, boards, [])
      calculate_score(Enum.at(winner,0))
  end

end
