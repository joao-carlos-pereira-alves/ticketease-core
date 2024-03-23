defmodule HelpDeskWeb.WorkspacesController do
  use HelpDeskWeb, :controller

  alias HelpDesk.Workspaces
  alias Workspaces.Workspace

  action_fallback HelpDeskWeb.FallbackController

  def create(conn, params) do
    %{ user_id: user_id } = conn.assigns

    with {:ok, %Workspace{} = workspace} <- Workspaces.create(params, user_id) do
      conn
      |> put_status(:created)
      |> render(:create, workspace: workspace)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Workspace{} = workspace} <- Workspaces.delete(id) do
      conn
      |> put_status(:ok)
      |> render(:delete, workspace: workspace)
    end
  end

  def index(conn, _) do
    %{ user_id: user_id } = conn.assigns

    with {:ok, workspaces, pagination, offset } <- Workspaces.get_all(user_id, conn.params) do
      conn
      |> put_status(:ok)
      |> render(:get, workspaces: workspaces, pagination: pagination, offset: offset)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Workspace{} = workspace} <- Workspaces.get(id) do
      conn
      |> put_status(:ok)
      |> render(:get, workspace: workspace)
    end
  end

  def update(conn, params) do
    with {:ok, %Workspace{} = workspace} <- Workspaces.update(params) do
      conn
      |> put_status(:ok)
      |> render(:update, workspace: workspace)
    end
  end
end
