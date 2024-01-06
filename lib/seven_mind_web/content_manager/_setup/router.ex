defmodule SevenMindWeb.ContentManager.Setup.Router do
  use AshJsonApi.Api.Router,
    # The api modules you want to serve
    apis: [SevenMindWeb.ContentManager.Setup.Api],
    # optionally a json_schema route
    json_schema: "/json_schema",
    # optionally an open_api route
    open_api: "/open_api",
    modify_open_api: {__MODULE__, :modify_open_api, []}

  def modify_open_api(spec, _, _) do
    servers = Enum.map(spec.servers, fn server ->
      %{server | url: "#{server.url}/api/content-manager"}
    end)
    
    %{spec | servers: servers}
  end
end
