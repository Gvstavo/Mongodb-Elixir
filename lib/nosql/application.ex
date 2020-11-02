defmodule Nosql.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  import Supervisor.Spec

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      NosqlWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Nosql.PubSub},
      # Start the Endpoint (http/https)
      NosqlWeb.Endpoint,

      worker(Mongo, [[name: :mongo, database: "test"]])
      # Start a worker by calling: Nosql.Worker.start_link(arg)
      # {Nosql.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Nosql.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    NosqlWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
