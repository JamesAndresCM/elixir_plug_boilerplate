import Config

config :<%= @app_name %>, :ecto_repos, [<%= @app_module %>.Repo]

# JSON parser
config :phoenix, :json_library, Jason

# Cargar config por entorno (dev.exs, prod.exs)
import_config "#{Mix.env()}.exs"
