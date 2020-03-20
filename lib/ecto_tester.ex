defmodule EctoTester do
  alias EctoTester.Repo

  import Ecto.Query

  def bench() do
    Benchee.run(
      %{
        "dsl" => fn -> dsl(~D[2019-01-01], ~D[2020-12-31]) end,
        "sql" => fn -> sql(~D[2019-01-01], ~D[2020-12-31]) end
      }, time: 10
    )
  end

  def dsl(from, to) do
    q =
      from(b in "table_b",
        where: b.int_field == 1 and b.date_field >= ^from and b.date_field <= ^to,
        select: b.id
      )

    Repo.all(q)
  end

  def sql(from, to) do
    Repo.query!(
      """
      SELECT t0."id"
      FROM "table_b" AS t0
      WHERE (((t0."int_field" = 1) AND (t0."date_field" >= $1)) AND (t0."date_field" <= $2))
      """,
      [from, to]
    )
  end
end
