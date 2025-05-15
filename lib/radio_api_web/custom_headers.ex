defmodule RadioApiWeb.Plugs.CustomHeaders do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    conn
    |> put_resp_content_type("text/plain", "utf-8")
    |> put_resp_header("expires", "Thu, 19 Nov 1981 08:52:00 GMT")
    |> put_resp_header("cache-control", "no-store, no-cache, must-revalidate")
    |> put_resp_header("pragma", "no-cache")
  end
end
