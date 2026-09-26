defmodule KkWeb.Plugs.CanonicalHost do
  import Plug.Conn

  @canonical "kkadwokat.pl"
  @aliases ~w(www.kkadwokat.pl kkadw.pl www.kkadw.pl adwgdansk.pl www.adwgdansk.pl)

  def init(opts), do: opts

  def call(%{host: host} = conn, _opts) when host in @aliases do
    qs = if conn.query_string == "", do: "", else: "?" <> conn.query_string

    conn
    |> put_resp_header("location", "https://#{@canonical}#{conn.request_path}#{qs}")
    |> send_resp(301, "")
    |> halt()
  end

  def call(conn, _opts), do: conn
end
