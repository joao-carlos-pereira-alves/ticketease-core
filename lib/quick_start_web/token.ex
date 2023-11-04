defmodule QuickStartWeb.Token do
  alias Phoenix.Token
  alias QuickStartWeb.Endpoint

  @sign_salt "quick_start_api"

  def sign(user) do
    Token.sign(Endpoint, @sign_salt, %{user_id: user.id})
  end

  def verify(token) do
    case Token.verify(Endpoint, @sign_salt, token) do
      {:ok, _data} = result -> result
      {:error, _error} = error -> error
    end
  end
end
