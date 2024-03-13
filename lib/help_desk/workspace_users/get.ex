defmodule HelpDesk.WorkspaceUsers.Get do
  import Ecto.Query

  alias HelpDesk.WorkspaceUsers.WorkspaceUser
  alias HelpDesk.Repo


  def call(id) do
    case Repo.get(WorkspaceUser, id) do
      nil -> { :error, :not_found}
      workspace_user -> { :ok, workspace_user}
    end
  end

  def get_all(current_user_id) do
    query = from w in WorkspaceUser,
          where: w.user_id == ^current_user_id,
          preload: :workspace

    case Repo.all(query) do
      [] -> {:error, :not_found}
      workspace_users -> {:ok, workspace_users}
    end
  end
end
