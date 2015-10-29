use Mix.Config

config :api, :postgrex,
  hostname: "localhost",
  username: "postgres",
  password: "postgres",
  database: "postgres"

config :api,
  basic_auth_user: "valid",
  basic_auth_password: "credentials"

config :ex_unit, trace: true
