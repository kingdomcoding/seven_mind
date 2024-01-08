defmodule SevenMind.CourseManagement.Tests.UseCasesTest do
  use SevenMind.DataCase

  import Commanded.Assertions.EventAssertions

  alias SevenMind.Application
  alias SevenMind.CourseManagement.UseCases
  alias SevenMind.CourseManagement.DomainEvents.CategoryCreated

  describe "Course Management Use Case happy path" do
    test "WHEN: A content manager tries to create a category, THEN: A category is created" do
      name = "Category Name"
      with {:ok, %{id: category_id} = _use_case_data} <- UseCases.create_category(name) do
        assert_receive_event(Application, CategoryCreated,
          fn event -> event.id == category_id end,
          fn event -> assert event.name == name end
        )
      else
        {:error, error} ->
          flunk("Expected category to be created but got: #{inspect(error)}")
      end
    end
  end
end
