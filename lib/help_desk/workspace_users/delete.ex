defmodule HelpDesk.WorkspaceUsers.Delete do
  alias HelpDesk.WorkspaceUsers.WorkspaceUser
  alias HelpDesk.Repo

  def call(id) do
    case Repo.get(WorkspaceUser, id) do
      nil -> { :error, :not_found}
      workspace_user -> Repo.delete(workspace_user)
    end
  end
end
