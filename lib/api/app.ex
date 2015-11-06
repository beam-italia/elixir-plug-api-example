defmodule App do

  def users do
    users = Api.Db.users
    {:ok, users}
  end

end
