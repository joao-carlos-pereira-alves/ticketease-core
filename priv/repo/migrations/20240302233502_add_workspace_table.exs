defmodule HelpDesk.Repo.Migrations.AddWorkspaceTable do
  use Ecto.Migration

  def change do
    create table(:workspaces) do
      add :title, :string
      add :description, :string
      add :responsible_email, :string
      add :status, :string, default: "active"

      timestamps()
    end
  end
end
