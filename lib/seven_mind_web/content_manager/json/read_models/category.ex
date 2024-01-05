defmodule SevenMindWeb.ContentManager.Json.ReadModels.Category do
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

      get :read
      index :read
    end
  end
end
