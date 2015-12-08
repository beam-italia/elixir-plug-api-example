defmodule Api.Db do

  def users do
    Api.Db.Supervisor.execute("select users.name, users.surname from users;")
    |> (fn r -> r.rows end).()
    |> to_structs
  end

  defp to_structs(users) do
    users
    |> Enum.map(fn [name, surname] -> %User{name: name, surname: surname} end)
  end

end
