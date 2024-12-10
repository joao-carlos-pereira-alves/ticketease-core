defmodule HelpDesk.Workspaces.Create do
  alias HelpDesk.WorkspaceUsers
  alias HelpDesk.Workspaces.Workspace
  alias HelpDesk.Repo

  def call(params, user_id) do
    params
    |> Workspace.changeset(user_id)
    |> Repo.insert()
    |> handle_insert_result(user_id)
  end

  defp handle_insert_result({:ok, workspace}, user_id) do
    create_workspace_users(user_id, workspace.id)
    {:ok, workspace}
  end

  defp handle_insert_result({:error, changeset}, _) do
    {:error, changeset}
  end

  defp create_workspace_users(user_id, workspace_id) do
    WorkspaceUsers.create(%{user_id: user_id, workspace_id: workspace_id})
  end
end
