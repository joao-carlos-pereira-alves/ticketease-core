defmodule HelpDesk.Repo.Migrations.AddBase64TokenColumnToWorkspaces do
  use Ecto.Migration

  def change do
    alter table("workspaces") do
      add :base64, :text
    end
  end
end
