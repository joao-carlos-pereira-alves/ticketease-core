defmodule HelpDeskWeb.UsersControllerTest do
  use HelpDeskWeb.ConnCase

  alias HelpDesk.Users
  alias Users.User

  import Mox

  setup :verify_on_exit!

  setup do
    user_params = %{name: "João", email: "test@example.com", password: "password123"}
    {:ok, user} = HelpDesk.Users.create(user_params)

    # Retornar o contexto do teste com o usuário criado
    {:ok, %{user: user}}
  end

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

    test "when the name has more than 50 characters, it returns an error", %{conn: conn} do
      params = %{
        name: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
        email: "teste@gmail.com",
        password: "123456"
      }

      response =
        conn
        |> post(~p"/api/v1/sign_up", params)
        |> json_response(:bad_request)

      expected_response = %{"errors" => %{"name" => ["should be at most 50 character(s)"]}}

      assert response == expected_response
    end

    test "when the name has less than 3 characters, it returns an error", %{conn: conn} do
      params = %{
        name: "Lo",
        email: "teste@gmail.com",
        password: "123456"
      }

      response =
        conn
        |> post(~p"/api/v1/sign_up", params)
        |> json_response(:bad_request)

      expected_response = %{"errors" => %{"name" => ["should be at least 3 character(s)"]}}

      assert response == expected_response
    end

    test "when the email is invalid, an error is returned", %{conn: conn} do
      params = %{
        name: "João",
        email: "teste",
        password: "123456"
      }

      response =
        conn
        |> post(~p"/api/v1/sign_up", params)
        |> json_response(:bad_request)

      expected_response = %{"errors" => %{"email" => ["has invalid format"]}}

      assert response == expected_response
    end
  end

  describe "login/2" do
    test "successfully sign in an user", %{conn: conn} do
      params = %{
        email: "test@example.com",
        password: "password123"
      }

      response =
        conn
        |> post(~p"/api/v1/sign_in", params)
        |> json_response(:ok)

      assert %{"message" => "Usuário autenticado com sucesso"} = response
      assert Map.has_key?(response, "token")
    end

    test "when the user does not exist, an error is returned", %{conn: conn} do
      params = %{
        email: "nil@example.com",
        password: "password123"
      }

      response =
        conn
        |> post(~p"/api/v1/sign_in", params)
        |> json_response(:not_found)

      assert %{"message" => "Usuário não encontrado"} = response
    end

    test "when the user's password is invalid, an error is returned", %{conn: conn} do
      params = %{
        email: "test@example.com",
        password: "password123456"
      }

      response =
        conn
        |> post(~p"/api/v1/sign_in", params)
        |> json_response(:unauthorized)

      assert %{"message" => "Senha incorreta"} = response
    end
  end
end
