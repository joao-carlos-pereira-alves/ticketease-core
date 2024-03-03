defmodule HelpDeskWeb.WorkspacesJSON do
  alias HelpDesk.Workspaces.Workspace

  def create(%{workspace: workspace}) do
    %{
      message: "Área de trabalho criada com sucesso.",
      data: data(workspace)
    }
  end

  def delete(%{workspace: workspace}), do: %{ message: "Área de trabalho excluída com sucesso.", data: data(workspace) }

  def get(%{workspace: workspace}), do: %{ data: data(workspace) }

  def update(%{workspace: workspace}), do: %{ message: "Área de trabalho atualizada com sucesso.", data: data(workspace) }

  defp data(%Workspace{} = workspace) do
    %{
      id: workspace.id
    }
  end
end
