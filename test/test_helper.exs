ExUnit.start()


defmodule Utils do
    def string_to_list_string(s) do
        s 
        |> String.split("\n")
        |> Enum.filter(fn x -> String.trim(x) != "" end)
    end
end