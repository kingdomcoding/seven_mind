defmodule SevenMindWeb.ContentManager.Setup.Api do
  use Ash.Api, extensions: [AshJsonApi.Api]

  resources do
    resource SevenMindWeb.ContentManager.Json.ReadModels.Category
  end
end
