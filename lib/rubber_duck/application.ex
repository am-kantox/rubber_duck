defmodule RubberDuck.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RubberDuckWeb.Telemetry,
      RubberDuck.Repo,
      {DNSCluster, query: Application.get_env(:rubber_duck, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: RubberDuck.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: RubberDuck.Finch},
      # Start a worker by calling: RubberDuck.Worker.start_link(arg)
      # {RubberDuck.Worker, arg},
      # Start to serve requests, typically the last entry
      RubberDuckWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RubberDuck.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RubberDuckWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
