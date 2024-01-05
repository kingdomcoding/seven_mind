defmodule SevenMindWeb.ContentManager.Json.CommandModels.Category do
  use Ash.Resource, extensions: [AshJsonApi.Resource], data_layer: Ash.DataLayer.Ets

  attributes do
    uuid_primary_key :id
    attribute :name, :string, allow_nil?: false
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  json_api do
    type "category"

    routes do
      base "/categories"

      post :create
      patch :update
    end
  end
end
