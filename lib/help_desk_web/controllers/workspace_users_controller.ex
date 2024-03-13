defmodule HelpDeskWeb.WorkspaceUsersController do
  use HelpDeskWeb, :controller

  alias HelpDesk.WorkspaceUsers
  alias WorkspaceUsers.WorkspaceUser

  action_fallback HelpDeskWeb.FallbackController

  def create(conn, params) do
    with {:ok, %WorkspaceUser{} = workspace_user} <- WorkspaceUsers.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, workspace_user: workspace_user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %WorkspaceUser{} = workspace_user} <- WorkspaceUsers.delete(id) do
      conn
      |> put_status(:ok)
      |> render(:delete, workspace_user: workspace_user)
    end
  end

  def index(conn, _) do
    %{ user_id: user_id } = conn.assigns

    with {:ok, workspaces} <- WorkspaceUsers.get_all(user_id) do
      conn
      |> put_status(:ok)
      |> render(:get, workspace_users: workspaces)
    end
  end
end
