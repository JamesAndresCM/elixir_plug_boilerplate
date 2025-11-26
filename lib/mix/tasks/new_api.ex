defmodule Mix.Tasks.NewApi do
  use Mix.Task
  alias Mix.Generator

  @shortdoc "Genera una API minimalista Plug + Ecto (Postgres) con PubSub y SSE"

  @moduledoc """
  mix new_api APP_NAME

  Crea un proyecto API minimalista usando Plug + Ecto (Postgres) y Phoenix.PubSub.
  """

  def run([app_name]) do
    app_module = Macro.camelize(app_name)
    create_dirs(app_name)
    copy_template("mix.exs", "#{app_name}/mix.exs", app_name, app_module)
    copy_template(".env_sample", "#{app_name}/.env_sample", app_name, app_module)
    copy_template("config/config.exs", "#{app_name}/config/config.exs", app_name, app_module)
    copy_template("config/dev.exs", "#{app_name}/config/dev.exs", app_name, app_module)
    copy_template("config/prod.exs", "#{app_name}/config/prod.exs", app_name, app_module)
    copy_template("lib/application.ex", "#{app_name}/lib/#{app_name}_api/application.ex", app_name, app_module)
    copy_template("lib/router.ex", "#{app_name}/lib/router.ex", app_name, app_module)
    copy_template("lib/repo.ex", "#{app_name}/lib/#{app_name}_api/repo.ex", app_name, app_module)
    copy_template("lib/repositories/.keep", "#{app_name}/lib/#{app_name}_api/repositories/.keep", app_name, app_module)
    copy_template("lib/schemas/.keep", "#{app_name}/lib/#{app_name}_api/schemas/.keep", app_name, app_module)
    copy_template("lib/utils/json.ex", "#{app_name}/lib/#{app_name}_api/utils/json.ex", app_name, app_module)
    copy_template("lib/routes/event_router.ex", "#{app_name}/lib/routes/event_router.ex", app_name, app_module)
    Generator.create_directory("#{app_name}/priv/repo/migrations")

    Mix.shell().info("""
    ✔ Proyecto #{app_name} generado correctamente!

    Pasos siguientes:
      cd #{app_name}
      mix deps.get
      # configura DATABASE_URL o ajusta config/config.exs
      mix ecto.create
      mix ecto.gen.migration create_examples
      mix ecto.migrate
      mix run --no-halt

    """)
  end

  defp create_dirs(app_name) do
    Generator.create_directory(app_name)
    Generator.create_directory("#{app_name}/config")
    #Generator.create_directory("#{app_name}/lib/#{app_name}")
    Generator.create_directory("#{app_name}/priv/templates/new_api")
  end

  defp copy_template(template, target, app_name, app_module) do
    Generator.copy_template(
      "priv/templates/new_api/#{template}",
      target,
      app_name: app_name,
      app_module: app_module
    )
  end
end
