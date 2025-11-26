import Config

config :<%= @app_name %>, port: 80

database_url = System.get_env("DATABASE_URL")

if database_url && database_url != "" do
  config :<%= @app_name %>, <%= @app_module %>.Repo,
    url: database_url,
    pool_size: 15
else
  config :<%= @app_name %>, <%= @app_module %>.Repo,
    database: "<%= @app_name %>_production",
    username: "postgres",
    password: "postgres",
    hostname: "localhost",
    pool_size: 15
end

