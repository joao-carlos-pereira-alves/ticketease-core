defmodule HelpDesk.Repo.Migrations.AddVerifiedColumnToUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :verified, :boolean, default: false, null: false
    end
  end
end
