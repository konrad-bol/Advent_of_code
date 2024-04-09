defmodule DataAdvent do
  alias Data.DataList, as: Data

  defdelegate get_data_1(), to: Data
  defdelegate get_data_2(), to: Data
end
