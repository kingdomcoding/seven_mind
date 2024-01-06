defmodule SevenMindWeb.Meditator.Setup.Api do
  use Ash.Api, extensions: [AshJsonApi.Api]

  resources do
    resource SevenMindWeb.Meditator.Json.CommandModels.Reminder
    resource SevenMindWeb.Meditator.Json.ReadModels.Reminder
  end
end
