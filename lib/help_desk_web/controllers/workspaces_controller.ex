defmodule HelpDeskWeb.WorkspacesController do
  use HelpDeskWeb, :controller

  alias HelpDesk.Workspaces
  alias Workspaces.Workspace

  action_fallback HelpDeskWeb.FallbackController

  def create(conn, params) do
    with {:ok, %Workspace{} = workspace} <- Workspaces.create(params) do
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
