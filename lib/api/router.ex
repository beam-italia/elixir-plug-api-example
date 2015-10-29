defmodule Api.Router do
  use Plug.Router

  plug PlugBasicAuth,
    username: Application.get_env(:api, :basic_auth_user),
    password: Application.get_env(:api, :basic_auth_password)

    plug :match
    plug :dispatch

  get "/users" do
    users = App.users
    send_resp(conn, 200, Poison.encode!(users))
  end

  match(_) do
    send_resp(conn, 404, "")
  end

end
