defmodule HelpDeskWeb.WorkspaceUsersJSON do
  import Ecto.Query

  alias HelpDesk.WorkspaceUsers.WorkspaceUser

  def create(%{workspace_user: workspace_user}) do
    %{
      message: "Associação criada com sucesso.",
      data: data(workspace_user)
    }
  end

  def get(%{workspace_users: workspace_users}), do: %{ data: data(workspace_users) }

  def delete(%{workspace_user: workspace_user}), do: %{ message: "Associação excluída com sucesso.", data: data(workspace_user) }

  defp data(workspace_users) when is_list(workspace_users) do
    Enum.map(workspace_users, &data/1)
  end

  defp data(%WorkspaceUser{workspace: workspace} = workspace_user) do
    %{
      id: workspace_user.id,
      workspace: %{id: workspace.id, title: workspace.title}
    }
  end
end
