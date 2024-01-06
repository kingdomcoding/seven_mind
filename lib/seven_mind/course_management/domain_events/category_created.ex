defmodule SevenMind.CourseManagement.DomainEvents.CategoryCreated do
  use Ash.Resource, data_layer: :embedded, extensions: [SevenMind.Ash.Extensions.JsonEncoder]

  attributes do
    attribute :id, :uuid, primary_key?: true, allow_nil?: false
    attribute :name, :string, allow_nil?: false
    attribute :event_version, :integer, default: 1
  end

  actions do
    defaults [:create, :read]
  end

  code_interface do
    define_for SevenMind.CourseManagement.Setup.Api
    define :create
  end
end
