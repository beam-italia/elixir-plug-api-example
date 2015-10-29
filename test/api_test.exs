defmodule ApiTest do
  use ExUnit.Case
  use Plug.Test

  alias Api.Router

  @username Application.get_env(:api, :basic_auth_user)
  @password Application.get_env(:api, :basic_auth_password)


  test "/users with incorrect credentials returns 401" do
    conn = conn(:get, "/users")
    |> put_req_header("authorization", auth_headers_for("invalid", "credentials"))
    |> Router.call([])

    assert conn.state == :sent
    assert conn.status == 401
  end

  test "/users with correct credentials returns 200" do
    conn = conn(:get, "/users")
    |> put_req_header("authorization", auth_headers_for(@username, @password))
    |> Router.call([])

    assert conn.state == :sent
    assert conn.status == 200
  end

  defp auth_headers_for(username, password) do
    "Basic " <> Base.encode64(username <> ":" <> password)
  end
end
