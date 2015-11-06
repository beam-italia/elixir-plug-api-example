defmodule Api.Router do
  use Plug.Router

  plug PlugBasicAuth,
    username: Application.get_env(:api, :basic_auth_user),
    password: Application.get_env(:api, :basic_auth_password)

    plug :match
    plug :dispatch

  get "/users" do
    {status, body} = handle_get(App.users)
    send_resp(conn, status, body)
  end

  match(_) do
    send_resp(conn, 404, "")
  end

  defp handle_get({:ok, users}), do: {200, encode(users)}

  defp handle_get({:error, _}), do: {400, "Some error"}

  defp encode(users) do
    Poison.encode!(users)
  end
end
