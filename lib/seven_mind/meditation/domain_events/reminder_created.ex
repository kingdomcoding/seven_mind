defmodule SevenMind.Meditation.DomainEvents.ReminderCreated do
  use Ash.Resource, data_layer: :embedded, extensions: [SevenMind.Ash.Extensions.JsonEncoder]

  attributes do
    attribute :id, :uuid, primary_key?: true, allow_nil?: false
    attribute :user_id, :uuid, allow_nil?: false
    attribute :time, :time, allow_nil?: false
    attribute :event_version, :integer, default: 1
  end

  actions do
    defaults [:create, :read]
  end

  code_interface do
    define_for SevenMind.Meditation.Setup.Api
    define :create
  end
end
