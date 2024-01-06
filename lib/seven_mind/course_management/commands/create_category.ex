defmodule SevenMind.CourseManagement.Commands.CreateCategory do
  use Ash.Resource, data_layer: :embedded

  attributes do
    uuid_primary_key :id
    attribute :name, :string, allow_nil?: false
  end

  actions do
    defaults [:create, :read]
  end

  code_interface do
    define_for SevenMind.CourseManagement.Setup.Api
    define :create
  end
end
