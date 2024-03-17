defmodule HelpDeskWeb.UsersJSON do
  alias HelpDesk.Users.User

  def create(%{user: user}) do
    %{
      message: "Usuário criado com sucesso.",
      data: data(user)
    }
  end

  def login(%{token: token, user: user}) do
    %{
      message: "Usuário autenticado com sucesso",
      token: token,
      data: data(user)
    }
  end

  def delete(%{user: user}), do: %{ data: data(user) }

  def get(%{user: user}), do: %{ data: data(user) }

  def update(%{user: user}), do: %{ message: "Usuário atualizado com sucesso.", data: data(user) }

  def verify_account(%{user: user}), do: %{ message: "Conta verificada com sucesso!", data: data(user) }

  def resend_verification_mailer(%{user: user}), do: %{ message: "Confirmação de e-mail enviado com sucesso!", data: data(user) }

  defp data(%User{} = user) do
    %{
      id: user.id,
      name: user.name,
      verified: user.verified || false
    }
  end
end
