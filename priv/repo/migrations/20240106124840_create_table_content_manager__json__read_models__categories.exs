defmodule SevenMind.Repo.Migrations.CreateTableContentManagerJsonReadModelsCategories do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    create table(:content_manager__json__read_models__categories, primary_key: false) do
      add :id, :uuid, null: false, primary_key: true
      add :name, :text, null: false
    end
  end

  def down do
    drop table(:content_manager__json__read_models__categories)
  end
end