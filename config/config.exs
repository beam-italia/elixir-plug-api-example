use Mix.Config

config :api, :postgrex,
  hostname: "localhost",
  username: "postgres",
  password: "postgres",
  database: "users"

config :api,
  basic_auth_user: "valid",
  basic_auth_password: "credentials",
  http_port: 4000

config :ex_unit, trace: true
