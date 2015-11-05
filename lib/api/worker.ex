defmodule Api.Worker do

  @http_port Application.get_env(:api, :http_port)

  def start_link do
    Plug.Adapters.Cowboy.http(Api.Router, [], port: @http_port)
  end

end
