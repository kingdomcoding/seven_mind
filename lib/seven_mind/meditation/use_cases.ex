defmodule SevenMind.Meditation.UseCases do
  alias SevenMind.Application
  
  def create_reminder(user_id, time) do
    with {:ok, command} <- SevenMind.Meditation.Commands.CreateReminder.create(%{user_id: user_id, time: time}),
          :ok <- Application.dispatch(command)
    do
      {:ok, command}
    end
  end
end
