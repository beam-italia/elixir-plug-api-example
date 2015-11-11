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

  post "/users" do
    {:ok, body, conn} = read_body(conn)
    App.add(decode(body))
    send_resp(conn, 201, "")
  end

  match(_) do
    send_resp(conn, 404, "")
  end

  defp encode(users) do
    Poison.encode!(users)
  end

  defp decode(body) do
    Poison.decode!(body, as: User)
  end
end
