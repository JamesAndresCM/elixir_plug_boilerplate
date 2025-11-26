defmodule Routes.EventRouter do  
  @moduledoc """
  Simple SSE endpoint using Phoenix.PubSub.
  Streams real-time events for a given user.
  """

  use Plug.Router
  import Plug.Conn

  plug :match
  plug :dispatch

  get "/events" do
    conn = fetch_query_params(conn)

    conn =
      conn
      |> put_resp_content_type("text/event-stream")
      |> put_resp_header("cache-control", "no-cache")
      |> put_resp_header("connection", "keep-alive")
      |> put_resp_header("access-control-allow-origin", "*")

    {:ok, conn} = send_chunked(conn, 200)

    user_id = conn.params["user_id"]

    if is_nil(user_id) do
      chunk(conn, "data: #{Jason.encode!(%{error: "user_id required"})}\n\n")
      conn
    else
      topic = "events:#{user_id}"
      Phoenix.PubSub.subscribe(<%= @app_module %>.PubSub, topic)

      # Notifica conexión
      chunk(conn, "data: #{Jason.encode!(%{type: "connected"})}\n\n")

      listen(conn)
    end
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end

  # ====================================
  # Internal recursive SSE loop
  # ====================================
  defp listen(conn) do
    receive do
      {event, payload} ->
        data = Jason.encode!(%{type: event, payload: payload})

        case chunk(conn, "data: #{data}\n\n") do
          {:ok, conn} ->
            listen(conn)

          {:error, _reason} ->
            :ok
        end
    after
      30_000 ->
        keepalive = Jason.encode!(%{type: "keep-alive"}) |> Jason.encode!()

        case chunk(conn, "data: #{keepalive}\n\n") do
          {:ok, conn} ->
            listen(conn)

          {:error, _reason} ->
            :ok
        end
    end
  end
end

