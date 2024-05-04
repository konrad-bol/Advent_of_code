defmodule Cube.DataSort do
  alias DataAdvent
    def divider() do
    DataAdvent.get_data_2()
    |> Enum.map(&(String.split(&1,[";",":",","])))
    |> Enum.map(&(div_id_game(&1)))
    end

    def convert_data({id,game}) do
     id_game=id
      |> String.replace_prefix("Game ","")
      |> String.to_integer()
      state_game= game
      |> Enum.map(&(String.split(&1," ",trim: true)))
      |> Enum.map(fn [x,y] ->
        Map.new([{String.to_atom(y),String.to_integer(x)}])
        |> Map.to_list()
        end)
      |> List.flatten()
      {id_game,state_game}
    end

    def div_id_game(list) do
        list
       |> List.pop_at(0)
       |> convert_data()
    end
end
