defmodule SevenMind.CourseManagement.UseCases do
  def create_category(category_name) do
    {:ok, %{id: Ecto.UUID.generate()}}
  end
end
