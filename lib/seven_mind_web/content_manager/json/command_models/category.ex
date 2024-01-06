defmodule SevenMindWeb.ContentManager.Json.CommandModels.Category do
  use Ash.Resource, extensions: [AshJsonApi.Resource], data_layer: Ash.DataLayer.Ets

  attributes do
    uuid_primary_key :id, writable?: true
    attribute :name, :string, allow_nil?: false
  end

  actions do
    defaults [:read]

    create :create do
      change fn changeset, context ->
        category_name = Map.get(changeset.attributes, :name)

        with {:ok, %{id: id} = _command} <- SevenMind.CourseManagement.UseCases.create_category(category_name) do
          attributes = Map.put(changeset.attributes, :id, id)
          %{changeset | attributes: attributes}
        else
          {:error, reason} ->
            Ash.Changeset.add_error(changeset, reason)
        end
      end
    end
  end

  code_interface do
    define_for SevenMindWeb.ContentManager.Setup.Api
    define :create
  end

  json_api do
    type "category"

    routes do
      base "/categories"

      post :create
    end
  end
end
