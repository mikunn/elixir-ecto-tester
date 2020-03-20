import Config

config :ecto_tester, EctoTester.Repo,
  database: "ecto_tester",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool_size: 3

config :ecto_tester, ecto_repos: [EctoTester.Repo]
