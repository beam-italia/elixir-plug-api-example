defmodule Api.Worker do
  def start_link do
    Plug.Adapters.Cowboy.http(Api.Router, [])
  end

end
