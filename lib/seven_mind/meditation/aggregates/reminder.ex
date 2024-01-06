defmodule SevenMind.Meditation.Aggregates.Reminder do
  use Ash.Resource, data_layer: :embedded
  use Commanded.Commands.Router

  alias SevenMind.Meditation.Commands.CreateReminder
  alias SevenMind.Meditation.DomainEvents.ReminderCreated

  attributes do
    attribute :id, :uuid, allow_nil?: false
  end

  dispatch CreateReminder, to: __MODULE__, identity: :id

  def execute(_aggregate_state, %CreateReminder{id: id, user_id: user_id, time: time} = _command) do
    ReminderCreated.create(%{id: id, user_id: user_id, time: time})
  end

  def apply(state, _event) do
    state
  end
end
