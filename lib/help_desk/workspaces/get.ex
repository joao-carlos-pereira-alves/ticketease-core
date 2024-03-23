defmodule HelpDesk.Workspaces.Get do
  import Ecto.Query

  alias HelpDesk.Workspaces.Workspace
  alias HelpDesk.WorkspaceUsers.WorkspaceUser
  alias HelpDesk.Repo

  def call(id) do
    case Repo.get(Workspace, id) do
      nil -> { :error, :not_found}
      workspace -> { :ok, workspace}
    end
  end

  def get_all(user_id, params) do
    query = from w in Workspace,
              where: w.responsible_id == ^user_id or
                    exists(
                      from uw in WorkspaceUser,
                        where: uw.user_id == ^user_id
                    ),
              select: w
    offset = count_items(query)
    query  = paginate(query, params)

    case Repo.all(query) do
      nil -> {:error, :not_found}
      workspaces -> {:ok, workspaces, params, offset}
    end
  end

  defp paginate(query, params) do
    per_page = case params["per_page"] do
      nil -> 5
      value -> String.to_integer(value)
    end

    page = case params["page"] do
      nil -> 1
      value -> String.to_integer(value)
    end

    offset = (page - 1) * per_page

    limit(query, ^per_page)
    |> offset(^offset)
  end

  defp count_items(query) do
    query
    |> Repo.all()
    |> length()
  end
end
