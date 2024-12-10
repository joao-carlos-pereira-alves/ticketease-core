defmodule HelpDesk.Workspaces.Delete do
  alias HelpDesk.Workspaces.Workspace
  alias HelpDesk.Repo

  def call(id) do
    case Repo.get(Workspace, id) do
      nil -> { :error, :not_found}
      workspace -> Repo.delete(workspace)
    end
  end
end
