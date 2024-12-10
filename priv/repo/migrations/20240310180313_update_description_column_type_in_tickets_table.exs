defmodule HelpDesk.Repo.Migrations.UpdateDescriptionColumnTypeInTicketsTable do
  use Ecto.Migration

  def change do
    alter table(:tickets) do
      modify :description, :text
    end
  end
end
