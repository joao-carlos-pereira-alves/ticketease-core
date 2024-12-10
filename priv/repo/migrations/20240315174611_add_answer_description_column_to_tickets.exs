defmodule HelpDesk.Repo.Migrations.AddAnswerDescriptionColumnToTickets do
  use Ecto.Migration

  def change do
    alter table("tickets") do
      add :answer_description, :text
    end
  end
end
