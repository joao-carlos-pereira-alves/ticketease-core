defmodule HelpDesk.WorkspaceUsers.Create do
  alias HelpDesk.WorkspaceUsers.WorkspaceUser
  alias HelpDesk.Repo

  def call(params) do
    params
    |> WorkspaceUser.changeset()
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
