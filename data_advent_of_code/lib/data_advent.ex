defmodule DataAdvent do
  alias Data.DataList, as: Data

  defdelegate get_data_1(), to: Data
  defdelegate get_data_2(), to: Data
  defdelegate get_data_3(), to: Data
  # camel case tomaszKamel jakasSuperFajnaZmienna
  # snake case tomasz_kamel jakas_super_fajna_zmienna
  # kebab case tomasz-kamel jakas-super-fajna-zmienna
end
