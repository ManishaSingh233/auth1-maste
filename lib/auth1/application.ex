defmodule Auth1.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Auth1.Repo,
      # Start the Telemetry supervisor
      Auth1Web.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Auth1.PubSub},
      # Start the Endpoint (http/https)
      Auth1Web.Endpoint
      # Start a worker by calling: Auth1.Worker.start_link(arg)
      # {Auth1.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Auth1.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Auth1Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
