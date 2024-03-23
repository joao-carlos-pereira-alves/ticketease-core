defmodule HelpDesk.Workspaces.Create do
  alias HelpDesk.Workspaces.Workspace
  alias HelpDesk.Repo

  def call(params, user_id) do
    params
    |> Workspace.changeset(user_id)
    |> Repo.insert()
    |> handle_insert_result()
  end

  defp handle_insert_result({:ok, workspace}) do
    {:ok, workspace}
  end

  defp handle_insert_result({:error, changeset}) do
    {:error, changeset}
  end
end
