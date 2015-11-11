defmodule App do

  def users do
    Api.Db.users
  end

  def add(user) do
    :ok = Api.Db.create(user)
  end

end
