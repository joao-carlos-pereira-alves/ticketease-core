defmodule HelpDesk.Users.Verify do
  alias HelpDesk.Users
  alias HelpDesk.Users.User
  alias HelpDeskWeb.Token

  @period_in_seconds Token.access_period_in_seconds

  def call(%{"id" => id, "totp_token" => totp_token}) do
    case Users.get(id) do
      {:ok, user} -> verify_totp(user, totp_token)
      {:error, _} = error -> error
    end
  end

  def call(%{"email" => email, "password" => password}) do
    case Users.get(%{"email" => email}) do
      {:ok, user} -> verify(user, password)
      {:error, _} = error -> error
    end
  end

  def resend_verification_account_mailer(%{"id" => id}) do
    %{totp_secret: totp_secret, totp_token: totp_token} = User.generate_totp_token()
    params = %{"id" => id, "totp_secret" => totp_secret, "totp_token" => totp_token, "verified" => false}

    case Users.update(params) do
      nil -> { :error, :not_found}
      {:ok, %User{} = user} ->
        User.resend_confirmation_email(user)
        { :ok, user}
    end
  end

  defp verify(user, password) do
    case Argon2.verify_pass(password, user.password_hash) do
      true -> {:ok, user}
      false -> {:error, %{ status: :unauthorized, message: "Senha incorreta" }}
    end
  end

  defp verify_totp(user, totp_token) do
    case NimbleTOTP.valid?(user.totp_secret, totp_token, [time: System.os_time(:second), period: @period_in_seconds]) do
      true ->
        if user.verified do
          {:error, %{status: :unauthorized, message: "Usuário já verificado"}}
        else
          update_verified_column(user)
        end
      false -> {:error, %{status: :unauthorized, message: "Token inválido"}}
    end
  end

  defp update_verified_column(user) do
    params = %{ "id" => user.id, "verified" => true}
    HelpDesk.Users.update(params)
  end
end
