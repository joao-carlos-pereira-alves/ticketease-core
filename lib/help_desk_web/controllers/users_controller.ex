defmodule HelpDeskWeb.UsersController do
  use HelpDeskWeb, :controller

  alias HelpDesk.Users
  alias HelpDeskWeb.Token
  alias Users.User

  action_fallback HelpDeskWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Users.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Users.delete(id) do
      conn
      |> put_status(:ok)
      |> render(:delete, user: user)
    end
  end

  def login(conn, params) do
    with {:ok, %User{} = user} <- Users.login(params) do
      token = Token.sign(user)
      conn
      |> put_status(:ok)
      |> render(:login, token: token, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Users.get(id) do
      conn
      |> put_status(:ok)
      |> render(:get, user: user)
    end
  end

  def show_current_user(conn, _) do
    %{ user_id: user_id } = conn.assigns

    with {:ok, %User{} = user} <- Users.get(user_id) do
      conn
      |> put_status(:ok)
      |> render(:get, user: user)
    end
  end

  def update(conn, params) do
    with {:ok, %User{} = user} <- Users.update(params) do
      conn
      |> put_status(:ok)
      |> render(:update, user: user)
    end
  end

  def verify_account(conn, params) do
    %{ user_id: user_id } = conn.assigns
    totp_token = params["totp_token"]
    verify_params = %{ "id" => user_id, "totp_token" => totp_token}

    with {:ok, %User{} = user} <- Users.validation_account(verify_params) do
      conn
      |> put_status(:ok)
      |> render(:verify_account, user: user)
    end
  end

  def resend_verification_code(conn, _) do
    %{ user_id: user_id } = conn.assigns

    with {:ok, %User{} = user} <- Users.resend_verification_account_code(%{ "id" => user_id}) do
      conn
      |> put_status(:ok)
      |> render(:resend_verification_mailer, user: user)
    end
  end
end
