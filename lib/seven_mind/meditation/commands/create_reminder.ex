defmodule SevenMind.Meditation.Commands.CreateReminder do
  use Ash.Resource, data_layer: :embedded

  attributes do
    uuid_primary_key :id
    attribute :user_id, :string, allow_nil?: false
    attribute :time, :time, allow_nil?: false
  end

  actions do
    defaults [:create, :read]
  end

  code_interface do
    define_for SevenMind.Meditation.Setup.Api
    define :create
  end
end
