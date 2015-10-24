defmodule Api.Db do

  @config Application.get_env(:api, :postgrex)

  def users do
    execute("select users.name, users.surname from users;", [])
    |> (fn r -> r.rows end).()
  end

  defp execute(query, params) do
    execute fn pid ->
      Postgrex.Connection.query!(pid, query, params)
    end
  end

  defp execute(cmd) do
    pid = get_connection

    try do
      cmd.(pid)
    after
      release_connection(pid)
    end

  end

  defp get_connection do
    {:ok, pid} = Postgrex.Connection.start_link(@config)
    pid
  end

  defp release_connection(pid) do
    Postgrex.Connection.stop(pid)
  end

end
