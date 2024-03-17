defmodule HelpDesk.Repo.Migrations.AddUniqValidationForEmailColumnInUsersTable do
  use Ecto.Migration

  def up do
    create unique_index(:users, [:email])
  end
end
