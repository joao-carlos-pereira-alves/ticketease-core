defmodule HelpDeskWeb.WorkspacesJSON do
  alias HelpDesk.Workspaces.Workspace

  def create(%{workspace: workspace}) do
    %{
      message: "Área de trabalho criada com sucesso.",
      data: data(workspace)
    }
  end

  def login(%{token: token}) do
    %{
      token: token,
      token_type: "Bearer"
    }
  end

  def delete(%{workspace: workspace}), do: %{ message: "Área de trabalho excluída com sucesso.", data: data(workspace) }

  def get(%{workspaces: workspaces, pagination: pagination, offset: offset}), do: %{ data: data(workspaces), pagination: pagination(offset, pagination)  }

  def get(%{workspace: workspace}), do: %{ data: data(workspace) }

  def update(%{workspace: workspace}), do: %{ message: "Área de trabalho atualizada com sucesso.", data: data(workspace) }

  defp data(workspaces) when is_list(workspaces) do
    Enum.map(workspaces, &data/1)
  end

  defp data(%Workspace{} = workspace) do
    %{
      id: workspace.id,
      title: workspace.title,
      description: workspace.description,
      status: workspace.status,
      base64: workspace.base64
    }
  end

  defp pagination(offset, pagination) do
    %{
      total: offset,
      per_page: pagination["per_page"],
      page: pagination["page"]
    }
  end
end
