defmodule SevenMindWeb.ContentManager.JSON.Tests.ReminderReadModelTest do
  use SevenMindWeb.ConnCase

  describe "Reminder Read Model happy path" do
    test "WHEN: A GET request is made to the index route, THEN: An empty data list is returned", %{conn: conn} do
      conn = get(conn, ~p"/api/meditator/reminders")
      %{"data" => data} = json_response(conn, 200)
      assert data == []
    end

    test "GIVEN: A reminder was created, WHEN: A GET request is made to the index route, THEN: A data list containing the reminder is returned", %{conn: conn} do
      # A randomly generated user_id is used as a placeholder
      # The user_id is extracted based on the authorization strategy used by the 7Mind app
      # Based on my review, that's most likely a JWT token
      user_id = Ecto.UUID.generate()
      time = Time.utc_now()
      {:ok, %{id: reminder_id}} = SevenMind.Meditation.UseCases.create_reminder(user_id, time)

      conn = get(conn, ~p"/api/meditator/reminders")
      %{"data" => data} = json_response(conn, 200)
      assert Enum.any?(data, fn reminder ->
        time =
          time
          |> Time.truncate(:second)
          |> Time.to_string()

        reminder["id"] == reminder_id && reminder["attributes"]["user_id"] == user_id && reminder["attributes"]["time"] == time
      end)
    end

    test "GIVEN: A reminder was created, WHEN: A GET request is made to the get route, THEN: The reminder is returned", %{conn: conn} do
      # A randomly generated user_id is used as a placeholder
      # The user_id is extracted based on the authorization strategy used by the 7Mind app
      # Based on my review, that's most likely a JWT token
      user_id = Ecto.UUID.generate()
      time = Time.utc_now()
      {:ok, %{id: reminder_id}} = SevenMind.Meditation.UseCases.create_reminder(user_id, time)

      conn = get(conn, ~p"/api/meditator/reminders/#{reminder_id}")
      %{"data" => reminder} = json_response(conn, 200)
      time =
        time
        |> Time.truncate(:second)
        |> Time.to_string()

      assert reminder["id"] == reminder_id && reminder["attributes"]["user_id"] == user_id && reminder["attributes"]["time"] == time
    end
  end
end
