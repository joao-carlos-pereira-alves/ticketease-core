defmodule HelpDeskWeb.WorkspaceUsersControllerTest do
  use HelpDeskWeb.ConnCase
  use ExUnit.Case
  use Bamboo.Test, shared: true

  alias HelpDesk.WorkspaceUsers
  alias WorkspaceUsers.WorkspaceUser

  describe "create/2" do
    setup [:create_user]
    setup [:create_workspace]

    test "successfully creates an workspace_user", %{conn: conn, workspace: workspace, user: user} do
      params = %{
        user_id: user.id,
        workspace_id: workspace.id
      }

      response =
        conn
        |> post(~p"/api/v1/workspace_users", params)
        |> json_response(:created)

      assert %{
               "data" => %{"id" => _id},
               "message" => "Associação criada com sucesso."
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{
        workspace_id: nil,
        user_id: nil
      }

      response =
        conn
        |> post(~p"/api/v1/workspace_users", params)
        |> json_response(:bad_request)

      expected_response = %{"errors" => %{"user_id" => ["can't be blank"], "workspace_id" => ["can't be blank"]}}

      assert response == expected_response
    end

    defp create_workspace(_) do
      workspace_params = %{
        title: "Lorem Ipsum",
        responsible_email: "hello@example.com"
      }

      {:ok, workspace} = HelpDesk.Workspaces.create(workspace_params)

      %{workspace: workspace}
    end

    defp create_user(_) do
      user_params = %{name: "João", email: "test@example.com", password: "password123"}

      {:ok, user} = HelpDesk.Users.create(user_params)

      %{user: user}
    end
  end

  # describe "delete/2" do
  #   setup [:create_workspace]

  #   test "successfully delete an workspace", %{conn: conn, workspace: workspace} do
  #     response =
  #       conn
  #       |> delete(~p"/api/v1/workspaces/#{workspace.id}")
  #       |> json_response(:ok)

  #     assert %{
  #              "data" => %{"id" => _id},
  #              "message" => "Área de trabalho excluída com sucesso."
  #            } = response
  #   end

  #   defp create_workspace(_) do
  #     workspace_params = %{
  #       title: "Lorem Ipsum",
  #       responsible_email: "hello@example.com"
  #     }

  #     {:ok, workspace} = HelpDesk.Workspaces.create(workspace_params)

  #     %{workspace: workspace}
  #   end
  # end
end
