defmodule EctoTester.Repo do
  use Ecto.Repo,
    otp_app: :ecto_tester,
    adapter: Ecto.Adapters.Postgres
end
