defmodule Api.Worker do

  def start_link do
    Plug.Adapters.Cowboy.http(Api.Router, [], port: Application.get_env(:api, :port))
  end

end
