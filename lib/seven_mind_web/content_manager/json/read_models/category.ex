defmodule SevenMindWeb.ContentManager.Json.ReadModels.Category do
  use Ash.Resource, extensions: [AshJsonApi.Resource], data_layer: AshPostgres.DataLayer

  use Commanded.Event.Handler,
    application: SevenMind.Application,
    name: "#{__MODULE__}",
    consistency: :strong

  alias SevenMind.CourseManagement.DomainEvents.CategoryCreated

  attributes do
    attribute :id, :uuid, primary_key?: true, allow_nil?: false
    attribute :name, :string, allow_nil?: false
  end

  actions do
    defaults [:create, :update, :destroy]

    read :read do
      pagination do
        offset? true
      end
    end
  end

  json_api do
    type "Category Queries"

    routes do
      base "/categories"

      get :read
      index :read
    end
  end

  code_interface do
    define_for SevenMindWeb.ContentManager.Setup.Api
    define :create
  end

  postgres do
    repo SevenMind.Repo
    table "content_manager__json__read_models__categories"
  end

  def handle(%CategoryCreated{id: category_id, name: name}, _metadata) do
    with {:ok, _category} <- __MODULE__.create(%{id: category_id, name: name}) do
      :ok
    end
  end
end
