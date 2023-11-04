defmodule ReservaOnlineWeb.UsersControllerTest do
  use ReservaOnlineWeb.ConnCase

  alias ReservaOnline.Users
  alias Users.User

  import Mox

  setup :verify_on_exit!

  describe "create/2" do
    test "successfully creates an user", %{conn: conn} do
      params = %{
        name: "João",
        email: "teste@gmail.com",
        password: "123456"
      }

      response =
        conn
        |> post(~p"/api/v1/sign_up", params)
        |> json_response(:created)

      assert %{
               "data" => %{"email" => "teste@gmail.com", "id" => _id, "name" => "João"},
               "message" => "User criado com sucesso."
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{
        name: nil,
        email: "teste@gmail.com",
        password: "123456"
      }

      response =
        conn
        |> post(~p"/api/v1/sign_up", params)
        |> json_response(:bad_request)

      expected_response = %{"errors" => %{"name" => ["can't be blank"]}}

      assert response == expected_response
    end
  end
end
