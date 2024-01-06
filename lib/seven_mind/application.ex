defmodule SevenMind.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  use Commanded.Application,
    otp_app: :seven_mind,
    event_store: [
      adapter: Commanded.EventStore.Adapters.EventStore,
      event_store: SevenMind.EventStore
    ]

  router SevenMind.CourseManagement.Aggregates.Category

  @impl true
  def start(_type, _args) do
    children = [
      SevenMindWeb.Telemetry,
      SevenMind.Repo,
      {DNSCluster, query: Application.get_env(:seven_mind, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: SevenMind.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: SevenMind.Finch},
      # Start a worker by calling: SevenMind.Worker.start_link(arg)
      # {SevenMind.Worker, arg},
      # Start to serve requests, typically the last entry
      SevenMindWeb.Endpoint,
      # Commanded
      __MODULE__,
      SevenMindWeb.ContentManager.Setup.Supervisor,
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SevenMind.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SevenMindWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
