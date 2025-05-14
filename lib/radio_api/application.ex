defmodule RadioApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RadioApiWeb.Telemetry,
      RadioApi.Repo,
      {DNSCluster, query: Application.get_env(:radio_api, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: RadioApi.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: RadioApi.Finch},
      # Start a worker by calling: RadioApi.Worker.start_link(arg)
      # {RadioApi.Worker, arg},
      # Start to serve requests, typically the last entry
      RadioApiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RadioApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RadioApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
