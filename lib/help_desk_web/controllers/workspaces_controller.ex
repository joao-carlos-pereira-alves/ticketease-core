defmodule HelpDeskWeb.WorkspacesController do
  use HelpDeskWeb, :controller

  alias HelpDesk.Workspaces
  alias Workspaces.Workspace
  alias HelpDeskWeb.Token

  action_fallback HelpDeskWeb.FallbackController

  def create(conn, params) do
    %{ user_id: user_id } = conn.assigns

    with {:ok, %Workspace{} = workspace} <- Workspaces.create(params, user_id) do
      conn
      |> put_status(:created)
      |> render(:create, workspace: workspace)
    end
  end

  def login(conn, params) do
    with {:ok, %Workspace{} = workspace} <- Workspaces.login(params) do
      token = Token.sign_api(workspace)
      conn
      |> put_status(:ok)
      |> render(:login, token: token)
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

  # def get_token(conn, _params) do
  #   user = Worksoaces.get(1)
  #   {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user)

  #   dbg(jwt)
  #   conn
  #   |> put_resp_content_type("application/json")
  #   |> send_resp(200, Jason.encode!(%{token: jwt}))
  # end
end
