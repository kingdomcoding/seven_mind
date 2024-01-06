defmodule SevenMind.CourseManagement.Aggregates.Category do
  use Ash.Resource, data_layer: :embedded
  use Commanded.Commands.Router

  alias SevenMind.CourseManagement.Commands.CreateCategory
  alias SevenMind.CourseManagement.DomainEvents.CategoryCreated

  attributes do
    attribute :id, :uuid, allow_nil?: false
  end

  dispatch CreateCategory, to: __MODULE__, identity: :id

  def execute(_aggregate_state, %CreateCategory{id: id, name: category_name} = _command) do
    CategoryCreated.create(%{id: id, name: category_name})
  end

  def apply(state, _event) do
    state
  end
end
