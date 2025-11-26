import Config

database_url = System.get_env("DATABASE_URL")

config :<%= @app_name %>, port: 4000

if database_url && database_url != "" do
  config :<%= @app_name %>, <%= @app_module %>.Repo,
    url: database_url,
    show_sensitive_data_on_connection_error: true,
    pool_size: 10
else
  config :<%= @app_name %>, <%= @app_module %>.Repo,
    database: "<%= @app_name %>_development",
    username: "postgres",
    password: "postgres",
    hostname: "localhost",
    show_sensitive_data_on_connection_error: true,
    pool_size: 10
end

