defmodule HelpDesk.Repo do
  use Ecto.Repo,
    otp_app: :help_desk,
    adapter: Ecto.Adapters.Postgres
end
