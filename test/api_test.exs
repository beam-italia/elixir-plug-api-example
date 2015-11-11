defmodule ApiTest do
  use ExUnit.Case
  use Plug.Test, async: false

  alias Api.Router

  @username Application.get_env(:api, :basic_auth_user)
  @password Application.get_env(:api, :basic_auth_password)

  import Mock

  setup_all do
    users = [%User{name: "Paolo", surname: "D'Incau"}]
    users_as_json = Poison.encode!(users)
    {:ok, users: users, users_as_json: users_as_json}
  end

  test "get /users with invalid credentials returns 401" do
    conn = unauthorized_request(:get, "/users")

    assert conn.state == :sent
    assert conn.status == 401
  end

  test_with_mock "get /users with valid credentials returns 200", %{users: users, users_as_json: users_as_json},
    App, [], [users: fn ->  users end] do
    conn = authorized_request(:get, "/users")

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == users_as_json
  end

  test "sets cors headers for external origins" do
    conn = conn(:get, "/")
            |> put_req_header("origin", "example.com")
            |> Router.call([])
    assert get_resp_header(conn, "access-control-allow-origin") == ["*"]
  end

  defp auth_headers_for(username, password) do
    "Basic " <> Base.encode64(username <> ":" <> password)
  end

  defp unauthorized_request(method, endpoint) do
    conn(method, endpoint)
      |> put_req_header("authorization", auth_headers_for("invalid", "credentials"))
      |> Router.call([])
  end

  defp authorized_request(method, endpoint) do
    conn(method, endpoint)
      |> put_req_header("authorization", auth_headers_for(@username, @password))
      |> Router.call([])
  end
end
