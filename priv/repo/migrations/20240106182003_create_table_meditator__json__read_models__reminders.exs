defmodule SevenMind.Repo.Migrations.CreateTableMeditatorJsonReadModelsReminders do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    create table(:meditator__json__read_models__reminders, primary_key: false) do
      add :id, :uuid, null: false, primary_key: true
      add :user_id, :uuid, null: false
      add :time, :time, null: false
    end
  end

  def down do
    drop table(:meditator__json__read_models__reminders)
  end
end