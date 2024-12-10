defmodule HelpDesk.Repo.Migrations.AddTotpColumnsToUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :totp_secret, :binary, null: true
      add :totp_token, :string, null: true
    end
  end
end
