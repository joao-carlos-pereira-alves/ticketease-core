defmodule HelpDeskWeb.WorkspaceUsersJSON do
  alias HelpDesk.WorkspaceUsers.WorkspaceUser

  def create(%{workspace_user: workspace_user}) do
    %{
      message: "Associação criada com sucesso.",
      data: data(workspace_user)
    }
  end

  def delete(%{workspace_user: workspace_user}), do: %{ message: "Associação excluída com sucesso.", data: data(workspace_user) }

  defp data(%WorkspaceUser{} = workspace_user) do
    %{
      id: workspace_user.id
    }
  end
end
