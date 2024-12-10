defmodule HelpDesk.Repo.Migrations.AddWorkspaceUsersTable do
  use Ecto.Migration

  def change do
    create table(:workspace_users) do
      add :workspace_id, references(:workspaces)
      add :user_id, references(:users)

      timestamps()
    end
  end
end
