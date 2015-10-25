use Mix.Config

config :api, :postgrex,
  hostname: "localhost",
  username: "postgres",
  password: "postgres",
  database: "users"

config :ex_unit, trace: true
