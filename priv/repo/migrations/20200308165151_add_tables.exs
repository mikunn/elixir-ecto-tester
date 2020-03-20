defmodule EctoTester.Repo.Migrations.AddTables do
  use Ecto.Migration

  def change do

    create table(:table_a) do
    end

    create table(:table_b) do
      add :table_a_id, references(:table_a, on_delete: :delete_all)
      add :int_field, :integer, null: false
      add :date_field, :date, null: false
    end

    create index(:table_b, [:table_a_id])
    create index(:table_b, [:int_field])
    create index(:table_b, [:date_field])
  end
end
