defmodule SevenMindWeb.Meditator.Json.CommandModels.Reminder do
  use Ash.Resource, extensions: [AshJsonApi.Resource]

  alias SevenMind.Meditation.DomainDataTypes.{Hour, Minute}

  attributes do
    uuid_primary_key :id, private?: true
    attribute :user_id, :uuid, allow_nil?: false, private?: true
    attribute :hour, :integer, allow_nil?: false, constraints: [min: 0, max: 23]
    attribute :minute, :integer, allow_nil?: false, constraints: [min: 0, max: 59]
  end

  actions do
    defaults [:read]

    create :create do
      change fn changeset, context ->
        # User ID is extracted based on the authorization strategy used by the 7Mind app
        # Based on my review, that's most likely a JWT token
        # A random UUID used as a placeholder
        user_id = Ecto.UUID.generate()

        hour = Map.get(changeset.attributes, :hour)
        minute = Map.get(changeset.attributes, :minute)
        {:ok, time} = Time.new(hour, minute, 0)

        with {:ok, %{id: id} = _command} <- SevenMind.Meditation.UseCases.create_reminder(user_id, time) do
          attributes =
            changeset.attributes
            |> Map.put(:id, id)
            |> Map.put(:user_id, user_id)

          %{changeset | attributes: attributes}
        else
          {:error, reason} ->
            Ash.Changeset.add_error(changeset, reason)
        end
      end
    end
  end

  code_interface do
    define_for SevenMindWeb.Meditator.Setup.Api
    define :create
  end

  json_api do
    type "Reminder Commands"

    routes do
      base "/reminders"

      post :create
    end
  end
end
