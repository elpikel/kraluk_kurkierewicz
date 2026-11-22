defmodule KralukKurkierewicz.IndexNow do
  @moduledoc """
  Notifies IndexNow (Bing, and through it ChatGPT search) about changed pages.

  Runs once on boot in production (see `KralukKurkierewicz.Application`), so every
  deploy submits the pages whose `KralukKurkierewicz.Sitemap` `lastmod` is recent.
  The key is public by design: search engines verify it by fetching
  `/<key>.txt` (`priv/static/<key>.txt`, listed in `static_paths/0`).
  """

  require Logger

  @key "2bef5543dec8ff57fea385375ce90574"
  @endpoint "https://api.indexnow.org/indexnow"
  # Pages changed within this many days before boot are submitted.
  @window_days 2

  @doc "Name of the key file served from the site root."
  def key_file, do: @key <> ".txt"

  @doc "Request body for the pages changed on or after `since`, or `nil` when there are none."
  def payload(%Date{} = since, base \\ KralukKurkierewiczWeb.Endpoint.url()) do
    urls =
      for {path, _priority, lastmod} <- KralukKurkierewicz.Sitemap.entries(),
          Date.compare(lastmod, since) != :lt,
          do: base <> String.trim_trailing(path, "/")

    if urls != [] do
      %{
        host: URI.parse(base).host,
        key: @key,
        keyLocation: base <> "/" <> key_file(),
        urlList: urls
      }
    end
  end

  @doc "Submits recently changed pages; never raises, failures are only logged."
  def submit_recent do
    with %{urlList: urls} = body <- payload(Date.add(Date.utc_today(), -@window_days)) do
      case Req.post(@endpoint, json: body, retry: false) do
        {:ok, %{status: status}} when status in 200..299 ->
          Logger.info("IndexNow: submitted #{length(urls)} URLs")

        {:ok, %{status: status}} ->
          Logger.warning("IndexNow: unexpected status #{status}")

        {:error, reason} ->
          Logger.warning("IndexNow: #{inspect(reason)}")
      end
    end

    :ok
  end
end
