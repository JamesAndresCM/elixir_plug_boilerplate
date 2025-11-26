defmodule Router do
  use Plug.Router
  use Plug.ErrorHandler

  alias <%= @app_module %>.Utils.JSON

  # Logs incoming requests
  plug Plug.Logger


  origins =
    [System.get_env("FRONTEND_URL"), "http://localhost:8000"]
    |> Enum.filter(&(&1 && &1 != ""))

  # CORS
  plug CORSPlug,
    origin: origins,
    methods: ["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"],
    headers: ["Content-Type", "Authorization", "Cache-Control"],
    max_age: 86_400

  # Match routes
  plug :match

  # Parse JSON body
  plug Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason

  # SSE events route - delegate
  forward "/api/v1/events", to: Routes.EventRouter

  # Other API routes
  # forward "/api/v1", to: Routes.OtherRouter

  plug :dispatch

  # Health check
  get "/health" do
    JSON.ok(conn, %{status: "ok"})
  end

  # Fallback
  match _ do
    conn
    |> Plug.Conn.put_resp_header("location", "/api/v1")
    |> Plug.Conn.send_resp(302, "Redirecting...")
    |> halt()
  end
end

