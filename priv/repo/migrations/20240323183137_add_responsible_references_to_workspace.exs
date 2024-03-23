defmodule HelpDesk.Repo.Migrations.AddResponsibleReferencesToWorkspace do
  use Ecto.Migration

  def change do
    alter table(:workspaces) do
      add :responsible_id, references(:users, on_delete: :nothing)
    end
  end
end
