defmodule SevenMind.CourseManagement.UseCases do
  alias SevenMind.Application
  
  def create_category(category_name) do
    with {:ok, command} <- SevenMind.CourseManagement.Commands.CreateCategory.create(%{name: category_name}),
          :ok <- Application.dispatch(command)
    do
      {:ok, command}
    else
      {:error, reason} ->
        {:error, reason}
    end
  end
end
