defmodule HelpDesk.Workspaces.Update do
  alias HelpDesk.Workspaces.Workspace
  alias HelpDesk.Repo

  def call(%{"id" => id} = params) do
    case Repo.get(Workspace, id) do
      nil -> { :error, :not_found}
      workspace -> update(workspace, params)
    end
  end

  defp update(workspace, params) do
    workspace
    |> Workspace.changeset(params)
    |> Repo.update()
  end
end
