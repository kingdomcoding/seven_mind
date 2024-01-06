defmodule SevenMindWeb.Meditator.Json.ReadModels.Reminder do
  use Ash.Resource, extensions: [AshJsonApi.Resource], data_layer: AshPostgres.DataLayer

  use Commanded.Event.Handler,
    application: SevenMind.Application,
    name: "#{__MODULE__}",
    consistency: :strong

  alias SevenMind.Meditation.DomainEvents.ReminderCreated

  attributes do
    attribute :id, :uuid, primary_key?: true, allow_nil?: false
    attribute :user_id, :uuid, allow_nil?: false
    attribute :time, :time, allow_nil?: false
  end

  actions do
    defaults [:create, :update, :destroy]

    read :read do
      pagination do
        offset? true
        default_limit 100
      end

      primary? true
    end
  end

  json_api do
    type "Reminder Queries"

    routes do
      base "/reminders"

      get :read
      index :read
    end
  end

  code_interface do
    define_for SevenMindWeb.Meditator.Setup.Api
    define :create
  end

  postgres do
    repo SevenMind.Repo
    table "meditator__json__read_models__reminders"
  end

  def handle(%ReminderCreated{id: reminder_id, user_id: user_id, time: time}, _metadata) do
    with {:ok, _category} <- __MODULE__.create(%{id: reminder_id, user_id: user_id, time: time}) do
      :ok
    end
  end
end
