defmodule ApiTest do
  use ExUnit.Case
  use Plug.Test

  import Api.Router

  @opts init([])

  test "/users returns 200" do
    res = conn(:get, "/users") |> call(@opts)

    assert res.state == :sent
    assert res.status == 200
  end
end
