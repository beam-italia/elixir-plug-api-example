defmodule Api.Worker do

  @port Application.get_env(:api, :http_port)

  def start_link do
    Plug.Adapters.Cowboy.http(Api.Router, [], port: @port)
  end

end
