defmodule EctoTester.Seeds.InitDB do
  def truncate_tables() do
    alias EctoTester.Repo

    tables_to_truncate = [
      "table_a",
      "table_b"
    ]

    to_truncate =
      tables_to_truncate
      |> Enum.join(", ")

    Repo.query!("TRUNCATE #{to_truncate} CASCADE", [])
  end
end

defmodule EctoTester.Seeds do
  alias EctoTester.Repo

  EctoTester.Seeds.InitDB.truncate_tables()

  @dates %{
    from: ~D[2017-01-01],
    to: ~D[2020-12-31]
  }

  @table_a_rows 10000
  @table_b_int_fields 500

  def build() do
    Repo.query!(
      """
      ALTER sequence table_a_id_seq restart with 1
      """
    )

    Repo.query!(
      """
      ALTER sequence table_b_id_seq restart with 1
      """
    )

    entries =
      1..@table_a_rows
      |> Enum.map(fn _ -> %{} end)

    {_, table_a_ids} = Repo.insert_all("table_a", entries, returning: [:id])

    dates =
      Date.range(@dates.from, @dates.to)
      |> Enum.map(fn date -> date end)

    table_a_ids
    |> Enum.map(&(&1.id))
    |> create_table_b_entries(dates)
  end

  defp create_table_b_entries(table_a_ids, dates) do
    table_a_ids
    |> Stream.map(fn table_a_id ->
      int_field = round(Float.ceil(table_a_id/@table_b_int_fields))
      dates
      |> Stream.map(fn date ->
        %{date_field: date, table_a_id: table_a_id, int_field: int_field}
      end)
    end)
    |> Stream.concat()
    |> Stream.chunk_every(1000)
    |> Stream.map(fn chunk ->
      Repo.insert_all("table_b", chunk)
    end)
    |> Stream.run()
  end
end

EctoTester.Seeds.build()
