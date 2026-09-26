defmodule KralukKurkierewicz.Repo do
  use Ecto.Repo,
    otp_app: :kraluk_kurkierewicz,
    adapter: Ecto.Adapters.Postgres
end
