defmodule SevenMindWeb.ContentManager.JSON.Tests.ReminderCommandModelTest do
  use SevenMindWeb.ConnCase

  describe "Reminder Command Model happy path" do
    test "WHEN: A valid POST request is made to the reminder post route, THEN: A success response is returned", %{conn: conn} do
      time = Time.utc_now()

      conn =
        conn
        |> put_req_header("content-type", "application/vnd.api+json")
        |> post(~p"/api/meditator/reminders/", %{data: %{attributes: %{hour: time.hour, minute: time.minute}}})

      %{"data" => reminder} = json_response(conn, 201)
      assert reminder["attributes"]["hour"] == time.hour
      assert reminder["attributes"]["minute"] == time.minute
    end

    test "GIVEN: A valid POST request was made to the reminder post route, WHEN: A GET request is made for the reminder, THEN: The reminder is returned", %{conn: conn} do
      time = Time.utc_now()

      conn =
        conn
        |> put_req_header("content-type", "application/vnd.api+json")
        |> post(~p"/api/meditator/reminders/", %{data: %{attributes: %{hour: time.hour, minute: time.minute}}})

      %{"data" => reminder} = json_response(conn, 201)
      reminder_id = reminder["id"]
      conn = get(conn, ~p"/api/meditator/reminders/#{reminder_id}")

      %{"data" => reminder} = json_response(conn, 200)
      reminder_time = Time.from_iso8601!(reminder["attributes"]["time"])
      assert reminder["id"] == reminder_id
      assert reminder_time.hour == time.hour
      assert reminder_time.minute == time.minute
    end
  end
end
