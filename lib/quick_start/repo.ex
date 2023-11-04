defmodule QuickStart.Repo do
  use Ecto.Repo,
    otp_app: :quick_start,
    adapter: Ecto.Adapters.Postgres
end
