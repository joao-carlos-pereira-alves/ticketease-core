defmodule HelpDesk.Workspaces.Get do
  alias HelpDesk.Workspaces.Workspace
  alias HelpDesk.Repo

  def call(id) do
    case Repo.get(Workspace, id) do
      nil -> { :error, :not_found}
      workspace -> { :ok, workspace}
    end
  end
end
