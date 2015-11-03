defmodule ApiTest do
  use ExUnit.Case
  use Plug.Test

  alias Api.Router

  @username Application.get_env(:api, :basic_auth_user)
  @password Application.get_env(:api, :basic_auth_password)

  import Mock

  test "/users with incorrect credentials returns 401" do
    conn = conn(:get, "/users")
    |> put_req_header("authorization", auth_headers_for("invalid", "credentials"))
    |> Router.call([])

    assert conn.state == :sent
    assert conn.status == 401
  end

  test "/users with correct credentials returns 200" do
    users = [%User{name: "Paolo", surname: "D'Incau"}]
    users_as_json = Poison.encode!(users)

    with_mock App, [users: fn ->  users end] do
      conn = conn(:get, "/users")
      |> put_req_header("authorization", auth_headers_for(@username, @password))
      |> Router.call([])

      assert conn.state == :sent
      assert conn.status == 200
      assert conn.resp_body == users_as_json
    end
  end

  defp auth_headers_for(username, password) do
    "Basic " <> Base.encode64(username <> ":" <> password)
  end
end
