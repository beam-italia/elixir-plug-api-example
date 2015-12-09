defmodule Api.Db.Worker do

  use GenServer

  @config Application.get_env(:api, :postgrex)
  
  def init(_) do
    Postgrex.Connection.start_link(@config)
  end

  def terminate(_, db_connection_pid) do
    Postgrex.Connection.stop(db_connection_pid)
  end

  def handle_call(query, _, db_connection_pid) do
    result_query = Postgrex.Connection.query!(db_connection_pid, query, [])
    {:reply, result_query, db_connection_pid}
  end

  def start_link([]) do
    :gen_server.start_link(__MODULE__, [], [])
  end

  def execute(pid, query) do
    :gen_server.call(pid, query)
  end

  def stop(pid) do
    :gen_server.stop(pid)
  end

end