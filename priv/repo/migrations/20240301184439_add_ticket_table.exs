defmodule HelpDesk.Repo.Migrations.AddTicketTable do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :subject, :string
      add :description, :string
      add :status, :string, default: "open"
      add :priority, :string, default: "low"
      add :tags, {:array, :string}

      timestamps()
    end
  end
end
