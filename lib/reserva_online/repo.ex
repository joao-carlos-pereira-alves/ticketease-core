defmodule ReservaOnline.Repo do
  use Ecto.Repo,
    otp_app: :reserva_online,
    adapter: Ecto.Adapters.Postgres
end
