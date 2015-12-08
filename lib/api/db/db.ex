defmodule Api.Db do

  def users do
    execute("select users.name, users.surname from users;")
    |> extract_rows
    |> to_structs
  end

  defp execute(query) do
    :poolboy.transaction(
      :db_connection,
      fn(pid) -> Api.Db.Worker.execute(pid, query) end,
      :infinity
    )
  end

  defp extract_rows(result_query) do
    result_query.rows
  end

  defp to_structs(users) do
    users
    |> Enum.map(fn [name, surname] -> %User{name: name, surname: surname} end)
  end

end
