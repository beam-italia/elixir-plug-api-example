defmodule ApiTest do
  use ExUnit.Case
  use Plug.Test

  alias Api.Router

  test "/users returns 200" do
    conn = conn(:get, "/users") |> Router.call([])

    assert conn.state == :sent
    assert conn.status == 200
  end
end
