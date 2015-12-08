defmodule Api do
  use Application

  def start(_type, _args) do
    Api.Supervisor.start_link
    Api.Db.Supervisor.start_link
  end
end
