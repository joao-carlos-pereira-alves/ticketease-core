defmodule HelpDesk.Repo.Migrations.AddWorkspaceReferencesToTickets do
  use Ecto.Migration

  def change do
    alter table("tickets") do
      add :workspace_id, references(:workspaces), null: false
    end
  end
end
