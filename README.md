# EctoTester

This small project (hopefully) demonstrates how running a particular query with the Query API multiple times ultimately slows down dramatically.

## How to run

1. Clone this project and go to the project's directory
2. Run `mix do deps.get, ecto.create, ecto.migrate`
3. Seed the database (it may take over 5 minutes)
	* `mix run priv/repo/seeds.exs`
4. Run the benchmarks with `mix run bench.exs`

You should see the `dsl` job slowing down at some point showing quite large deviation in the results, while
the `sql` job has much more solid benchmark. 
