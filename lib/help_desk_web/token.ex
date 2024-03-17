defmodule HelpDeskWeb.Token do
  @moduledoc """
  Handles creating and validating tokens.
  """

  require Logger

  alias Phoenix.Token
  alias HelpDeskWeb.Endpoint

  @sign_salt "help_desk_api"
  @period_in_seconds 1800

  def sign(user) do
    Token.sign(Endpoint, @sign_salt, %{user_id: user.id})
  end

  def verify(token) do
    case Token.verify(Endpoint, @sign_salt, token) do
      {:ok, _data} = result -> result
      {:error, _error} = error -> error
    end
  end

  def generate_totp_token() do
    totp_secret = NimbleTOTP.secret()
    totp_token  = NimbleTOTP.verification_code(totp_secret, [time: System.os_time(:second), period: @period_in_seconds])

    %{totp_secret: totp_secret, totp_token: totp_token}
  end

  def access_period_in_seconds do
    @period_in_seconds
  end
end
