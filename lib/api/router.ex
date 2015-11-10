defmodule Api.Router do
  use Plug.Router

  plug Corsica, max_age: 600, origins: "*"
  plug PlugBasicAuth,
    username: Application.get_env(:api, :basic_auth_user),
    password: Application.get_env(:api, :basic_auth_password)

    plug :match
    plug :dispatch

  get "/users" do
    send_resp(conn, 200, encode(App.users))
  end

  match(_) do
    send_resp(conn, 404, "")
  end

  defp encode(users) do
    Poison.encode!(users)
  end
end
