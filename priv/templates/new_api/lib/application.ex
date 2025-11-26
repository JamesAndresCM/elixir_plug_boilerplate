defmodule <%= @app_module %>.Application do
  use Application
  require Logger

  def start(_type, _args) do
    children = [
      <%= @app_module %>.Repo,
      {Phoenix.PubSub, name: <%= @app_module %>.PubSub},
      {Plug.Cowboy, scheme: :http, plug: Router, options: [port: 4000]}
    ]

    opts = [strategy: :one_for_one, name: <%= @app_module %>.Supervisor]
    Logger.info "The server listening at port: #{port()}"
    Supervisor.start_link(children, opts)
  end

  defp port, do: Application.get_env(:<%= @app_name %>, :port, 4000)
end
