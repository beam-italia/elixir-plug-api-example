defmodule App do

  defmodule User do
    @derive [Poison.Encoder]
    defstruct [:name, :surname]
  end

  def users do
    Api.Db.users
    |> to_structs
  end

  defp to_structs(users) do
    users
    |> Enum.map(fn [name, surname] -> %User{name: name, surname: surname} end)
  end

end
