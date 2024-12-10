defmodule HelpDesk.Repo.Migrations.AddWorkspaceReferencesToUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :workspace_id, references(:workspaces, on_delete: :delete_all), null: true
    end
  end
end
