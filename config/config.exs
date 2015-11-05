use Mix.Config

config :api, :postgrex,
  hostname: "localhost",
  username: "postgres",
  password: "postgres",
  database: "users"

config :api,
  basic_auth_user: "valid",
  basic_auth_password: "credentials"

import_config "#{Mix.env}.exs"