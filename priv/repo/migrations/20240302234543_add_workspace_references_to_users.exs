defmodule HelpDesk.Repo.Migrations.AddWorkspaceReferencesToUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :workspace_id, references(:workspaces)
    end
  end
end
