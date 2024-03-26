defmodule RubberDuckWeb.ChatController do
  use RubberDuckWeb, :controller

  @nd_json_content_type "application/x-ndjson"

  def stream(conn, %{"request" => request}) do
    conn =
      conn
      |> put_resp_content_type(@nd_json_content_type)
      |> send_chunked(200)

    RubberDuck.ChatCompletion.call(request,
      callback: fn data ->
        result = Jason.encode!(data)
        chunk(conn, result)
        chunk(conn, "\n")
      end
    )

    conn
  end
end
