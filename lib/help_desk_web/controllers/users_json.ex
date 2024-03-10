defmodule HelpDeskWeb.UsersJSON do
  alias HelpDesk.Users.User

  def create(%{user: user}) do
    %{
      message: "User criado com sucesso.",
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

  defp data(%User{} = user) do
    %{
      id: user.id,
      name: user.name
    }
  end
end
