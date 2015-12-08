defmodule Api.Db.Supervisor do
  
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    poolboy_config = [
      {:name, {:local, :db_connection}},
      {:worker_module, Api.Db.Worker},
      {:size, 2},
      {:max_overflow, 1}
    ]

    children = [
      :poolboy.child_spec(:db_connection, poolboy_config)
    ]

    options = [
      strategy: :one_for_one,
      name: Api.Db.Supervisor
    ]

    supervise(children, options)
  end

  def execute(query) do
    :poolboy.transaction(
      :db_connection,
      fn(pid) -> Api.Db.Worker.execute(pid, query) end,
      :infinity
    )
  end

end