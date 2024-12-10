defmodule HelpDeskWeb.WorkspacesControllerTest do
  use HelpDeskWeb.ConnCase
  use ExUnit.Case
  use Bamboo.Test, shared: true

  alias HelpDesk.Workspaces
  alias Workspaces.Workspace

  describe "create/2" do
    test "successfully creates an workspace", %{conn: conn} do
      params = %{
        title: "Lorem Ipsum",
        responsible_email: "hello@example.com"
      }

      response =
        conn
        |> post(~p"/api/v1/workspaces", params)
        |> json_response(:created)

      assert %{
               "data" => %{"id" => _id},
               "message" => "Área de trabalho criada com sucesso."
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{
        title: nil,
        responsible_email: nil
      }

      response =
        conn
        |> post(~p"/api/v1/workspaces", params)
        |> json_response(:bad_request)

      expected_response = %{"errors" => %{"responsible_email" => ["can't be blank"], "title" => ["can't be blank"]}}

      assert response == expected_response
    end

    # TODO: Falta criar testes para os seguintes casos: Verificar se a validação de
    # número de caracteres máximos para título está ok.
  end

  describe "delete/2" do
    setup [:create_workspace]

    test "successfully delete an workspace", %{conn: conn, workspace: workspace} do
      response =
        conn
        |> delete(~p"/api/v1/workspaces/#{workspace.id}")
        |> json_response(:ok)

      assert %{
               "data" => %{"id" => _id},
               "message" => "Área de trabalho excluída com sucesso."
             } = response
    end

    defp create_workspace(_) do
      workspace_params = %{
        title: "Lorem Ipsum",
        responsible_email: "hello@example.com"
      }

      {:ok, workspace} = HelpDesk.Workspaces.create(workspace_params)

      %{workspace: workspace}
    end
  end
end
