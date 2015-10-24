defmodule Api.Supervisor do

  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, Api.Router, [], [])
    ]
    supervise(children, strategy: :one_for_one)
  end

end
