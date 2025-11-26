defmodule <%= @app_module %>.Utils.JSON do
  @moduledoc "Helper minimalista para respuestas JSON en Plug apps."

  import Plug.Conn

  def ok(conn, data) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(data))
  end

  def created(conn, data) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(201, Jason.encode!(data))
  end

  def bad_request(conn, reason) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(400, Jason.encode!(%{error: reason}))
  end

  def not_found(conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(404, Jason.encode!(%{error: "not found"}))
  end

  def error(conn, status, reason) when is_integer(status) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, Jason.encode!(%{error: reason}))
  end
end

