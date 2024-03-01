defmodule HelpDesk.Repo.Migrations.AddTicketTable do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :subject, :string
      add :description, :string
      add :status, :string
      add :priority, :string # O campo priority ainda será uma string na migração inicial
      add :tags, {:array, :string} # O campo tags será um array de strings na migração inicial

      timestamps()
    end
  end
end
