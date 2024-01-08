defmodule SevenMind.Meditation.Tests.UseCasesTest do
  use SevenMind.DataCase

  import Commanded.Assertions.EventAssertions

  alias SevenMind.Application
  alias SevenMind.Meditation.UseCases
  alias SevenMind.Meditation.DomainEvents.ReminderCreated

  describe "Reminder Use Case happy path" do
    test "WHEN: A meditator tries to create a reminder, THEN: A reminder is created" do
      user_id = Ecto.UUID.generate()
      time = Time.utc_now()

      with {:ok, %{id: reminder_id} = _use_case_data} <- UseCases.create_reminder(user_id, time) do
        assert_receive_event(Application, ReminderCreated,
          fn event -> event.id == reminder_id end,
          fn event ->
            event_time = Time.from_iso8601!(event.time)

            assert event.user_id == user_id
            assert event_time.hour == time.hour
            assert event_time.minute == time.minute
          end
        )
      else
        {:error, error} ->
          flunk("Expected reminder to be created but got: #{inspect(error)}")
      end
    end
  end
end
