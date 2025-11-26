# plug_api_template

Boilerplate generator and templates for minimal Plug + Ecto (Postgres) APIs with Phoenix.PubSub and SSE.

## Usage

1. Clone this repo (or copy files) to your machine.
2. From the repo root run the generator:

```bash
mix new_api my_service
cd my_service
mix deps.get
# Configure DATABASE_URL or adjust config/config.exs
mix ecto.create
mix ecto.gen.migration create_examples
# edit the migration (create table examples with name:string)
mix ecto.migrate
mix run --no-halt
```

This will start a Plug/Cowboy server on port 4000.

- SSE endpoint: `GET /events/:user_id`
- Example REST endpoints: `GET /examples` and `POST /examples`
