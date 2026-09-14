import Config

config :<%= @app_name %>, port: 80

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :<%= @app_name %>, <%= @app_module %>.Repo,
  url: database_url,
  pool_size: 15

