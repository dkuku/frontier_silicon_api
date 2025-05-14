defmodule RadioApi.Repo do
  use Ecto.Repo,
    otp_app: :radio_api,
    adapter: Ecto.Adapters.Postgres
end
